
#include "FlowSolver.hpp"
#include "IdealGasSolver.hpp"
#include "PremixedSolver.hpp"
#include "IdealGasSolverWithLsp.hpp"
#include "HelmholtzSolver.hpp"
#include "NonpremixedSolver.hpp"
#include "BasicPostpro.hpp"

const double uStar = 0.4958;
const double z0 = 0.366;
const double disp = 6.66;
const double domain_height = 192;
const double vK_const = 0.41;
const double building_height = 6;

//==================================================================================
// following solver types are defined below
//      -- IdealGasSolver : non-reacting, compressible solver
//                          (IdealGasSolverWithLsp -- includes lagrangian particles)
//      -- PremixedSolver : reacting, (partially) premixed compressible solver
//                            based on flamelet-prog var approach
//      -- HelmholtzSolver : non-reacting, low-Ma fractional step solver
//      -- BasicPostpro    : eos agnostic postprocessing code
//
// each of these solvers is has a customized skeleton below that inherits from the
// base flow solver , e.g.,
//
//    class MyIdealGasSolver : public IdealGasSolver {};
//
// that exposes the hooks available to customize the flow solver.  Each solver type
// defined above has a similar list of hooks:
//
//         initialHook() : for defining initial conditions or setting data before
//                         the solver runs
//
//         temporalHook() : access to the data for diagnostics (or manipulation --
//                          but be careful) after the conclusion of each time step
//                          or snapshot processing
//
//         finalHook()    : access to the data for diagnostics (or manipulation)
//                          just prior to the solver exit
//
// Flow solvers also have the ability to provide custom boundary conditions defined
// through the definition of
//
//         initHookBc(BfZone* p) { return new BcObject(); }
//
// where an accompanying boundary condition class must also be specified
//
//         class BcObject : public ... {};
//
//
// Flow solvers also have hooks for custom forcing that is added to the rhs of the
// transport equations (for both the transported vars associated with the flow state
// as well as any passive scalars that were requested with the solution)
//
//         addSourceHook(Rhs* rhs, const double time, const int rk_stage) {}
//
// Custom data types can be registered in the constructors including setting of
// requests for the I/O state (data to be read and/or written, or neither) as annotated
// in the class below.  Memory management associated with registered data is left to
// the user to allocate in initData(), and subsequently de-allocated.
//
// The IdealGasSolver is annotated with some possible examples below, but the patterns
// will apply to all of the flow solvers.  Additional examples of custom setups of
// cases (boundary conditions, hooks, etc), can be found in the src/quiver directory
//
//==================================================================================

//===============================
// IdealGasSolver
//===============================

class MyIdealGasSolver : public IdealGasSolver {
public:

  /*
  double (* vort)[3];         // = curl(u);
  double * vort_mag;          // = |curl(u)|
  */

  MyIdealGasSolver() {

    /*
    vort     = NULL;  registerCvData( vort, "vort", READWRITE_DATA);
    vort_mag = NULL;  registerCvData( vort_mag, "vort_mag", NO_READWRITE_DATA);
    */
  }

  void initData() {

    IdealGasSolver::initData();

    /*
    assert( vort == NULL);     vort     = new double[ncv_g2][3];  // include vort calculation in ghosts...
    assert( vort_mag == NULL); vort_mag = new double[ncv];        // no ghosts ...
    */

  }

  ~MyIdealGasSolver() {

    /*
    DELETE(vort);
    DELETE(vort_mag);
    */

  }

  void initialHook() {}

  void temporalHook() {

    /*
    if ( step % check_interval == 0) {

      if ( mpi_rank == 0 )
        cout << " > computing vorticity ... " << endl;

      for (int icv = 0; icv < ncv; ++icv) {

        vort[icv][0]  = dudx[icv][2][1] - dudx[icv][1][2];
        vort[icv][1]  = dudx[icv][0][2] - dudx[icv][2][0];
        vort[icv][2]  = dudx[icv][1][0] - dudx[icv][0][1];

        vort_mag[icv] = MAG(vort[icv]);

      }

      updateCv2Data(vort, REPLACE_ROTATE_DATA);

    }
    */

  }

  void finalHook() {}

  IdealGasBc* initHookBc(BfZone* p) {
    CERR(" > user must supply a hook boundary condition for zone: " << p->getName());
  }

  void addSourceHook(IdealGasRhs* rhs, const double time, const int rk_stage) {}

};

//===============================
// PremixedSolver
//===============================

class MyPremixedSolver : public PremixedSolver {
public:

  MyPremixedSolver() {}

  void initData() {

    PremixedSolver::initData();

  }

  ~MyPremixedSolver() {}

  void initialHook() {}

  void temporalHook() {}

  void finalHook() {}

  PremixedBc* initHookBc(BfZone* p) {
    CERR(" > user must supply a hook boundary condition for zone: " << p->getName());
  }

  void addSourceHook(PremixedRhs* rhs, const double time, const int rk_stage) {}

};

//===============================
// HelmholtzSolver
//===============================


class MyHelmholtzSolver : public HelmholtzSolver {
public:

  MyHelmholtzSolver() {}

  void initData() {

    HelmholtzSolver::initData();

  }

  ~MyHelmholtzSolver() {}
  
  void initialHook() {
    if (step == 0) {
      if ( mpi_rank == 0 ) 
        cout << ">>>>> specifying initial velocity field and Temp" << endl;

      const double H_scaled = domain_height - disp;
      const double u_bulk = uStar/vK_const*(H_scaled*log(H_scaled/z0) - H_scaled + 1)/domain_height;

      FOR_ICV {

        rho[icv] = 1.0;

        const double y = x_cv[icv][1];
        const double absy = abs(y);

        // approximate log law mean profile
        double y_scaled = (absy-disp)/z0;
        y_scaled = max(1.0, y_scaled);
        const double u_loglaw = (uStar/vK_const)*log(y_scaled);

        const double u_parr = 2*(u_loglaw - u_bulk*(absy/domain_height));

        u[icv][0] = u_parr*cos(theta_wind);
        u[icv][2] = u_parr*sin(theta_wind);
        u[icv][1] = 0.001;
          
        // transport_scalar_vec[0][icv]=-0.1*absy;

        // // add perturbations
        // const double perturbation_scaling = 0.1;
        // double uy_pert = ux*perturbation_scaling*double(rand())/double(RAND_MAX)-0.5;
        // double uz_pert = ux*perturbation_scaling*double(rand())/double(RAND_MAX)-0.5;

        // u[icv][0] -= uy_pert+uz_pert;
        // u[icv][1] += uy_pert;
        // u[icv][2] += uz_pert;

      }
    }
  }

  void temporalHook() {}

  void finalHook() {}

  HelmholtzBc* initHookBc(BfZone* p) {
    CERR(" > user must supply a hook boundary condition for zone: " << p->getName());
  }


  // the Helmholtz solver has implicit time advancement in a fractional
  // step setting; as a result, the hooks for add source hooks are slightly
  // different.

  void momentumSourceHook(double * A,double (*rhs)[3]) {

    if ( mpi_rank == 0 ) 
    cout << ">>>>> adding momentum source" << endl;

    const double factor = momentum_scaling_factor;

    FOR_ICV {
      const double y = x_cv[icv][1];
      if ( y > 1.5*building_height){
        const double mom_source = factor*vol_cv[icv]*pow(uStar,2)/domain_height;
        rhs[icv][0] += cos(theta_wind)*mom_source;
        rhs[icv][2] += sin(theta_wind)*mom_source;
      } 
    }

//     if ( mpi_rank == 0 ) 
//       cout << ">>>>> adding momentum source, Boussinesq appriximation" << endl;

//       const double T_ref = 0.0;
//       const double beta = 0.0034; 
//       const double g = 10;
//       const double T_factor = 1.0;
    
//     if ( mpi_rank == 0 ) 
//       cout << ">>>>> T_ref= "<< T_ref << ", beta= "<<beta << ", g="<< g << endl;

// //      transport_scalar_vec[0][icv]=50.0;
//       FOR_ICV{
//         rhs[icv][1] += T_factor*vol_cv[icv]*rho[icv]*g*beta*(transport_scalar_vec[0][icv]-T_ref);
//       }
  }
  void massSourceHook(double * rhs) {}

};


class MyNonpremixedSolver : public NonpremixedSolver {};

class MyIdealGasSolverWithLsp : public IdealGasSolverWithLsp {
public:

  MyIdealGasSolverWithLsp() {}

  void initData() {

    IdealGasSolverWithLsp::initData();

  }

  ~MyIdealGasSolverWithLsp() {}

  void initialHook() {

    IdealGasSolverWithLsp::initialHook();

  }

  void temporalHook() {

    // if you like to check the containment of particles in the domain
    if (step%check_interval==0) {
      checkLpContain();
    }

  }

  void finalHook() {

    IdealGasSolverWithLsp::finalHook();

  }

  //IdealGasBc* initHookBc(BfZone* p) {
  //  CERR(" > user must supply a hook boundary condition for zone: " << p->getName());
  //}

  void addSourceHook(IdealGasRhs* rhs, const double time, const int rk_stage) {}

};

//===============================
// postpro
//===============================

class MyBasicPostpro : public BasicPostpro {
public:

  MyBasicPostpro() {}

  void initData() {

    BasicPostpro::initData();

  }

  ~MyBasicPostpro() {}

  void initialHook() {}

  void temporalHook() {}

  void finalHook() {}

};


int main(int argc, char* argv[]) {

  try {

    CTI_Init(argc,argv,"charles.in");

    {

      const bool b_post = checkParam("POST");

      if (Param * param = getParam("EOS")) {
        const string eos = param->getString();
        if ( eos == "IDEAL_GAS") {

          MyIdealGasSolver solver;

          if (b_post) {

            solver.initMin();
            solver.runPost();

          } else {

            solver.init();
            solver.run();
          }
        }
        else if (eos == "IDEAL_GAS_LSP") {

          MyIdealGasSolverWithLsp solver;

          if (b_post) {

            solver.initMin();
            solver.runPost();

          } else {

            solver.init();
            solver.run();
          }
        }
        else if ((eos == "PREMIXED_FPV") || (eos == "PREMIXED")) {

          MyPremixedSolver solver;

          if ( b_post) {

            solver.initMin();
            solver.runPost();

          } else {

            solver.init();
            solver.run();
          }
        }
        else if ((eos == "NONPREMIXED_FPV") || (eos == "NONPREMIXED") || (eos == "NON-PREMIXED") || (eos == "NON-PREMIXED_FPV")) {

          MyNonpremixedSolver solver;

          if ( b_post) {

            solver.initMin();
            solver.runPost();

          } else {

            solver.init();
            solver.run();

          }
        }
        else if ( eos == "HELMHOLTZ") {

          MyHelmholtzSolver solver;

          if ( b_post) {

            solver.initMin();
            solver.runPost();

          } else {

            solver.init();
            solver.run();
          }
        }
        else {
          CERR("unrecognized EOS: " << eos << ", possible choices are \n" <<
               "EOS IDEAL_GAS\n" <<
               "EOS PREMIXED_FPV\n" <<
               "EOS NONPREMIXED_FPV\n" <<
               "EOS IDEAL_GAS_LSP");
        }
      }
      else {

        if ( b_post) {

          // if there is no eos object provided but we are in a post
          // mode then we need to just start a stripped down staticsolver

          MyBasicPostpro solver;
          solver.initMin();
          solver.runPost();

        } else {

          CERR("must specify EOS or POST. Possible choices for EOS are \n" <<
               "EOS IDEAL_GAS\n" <<
               "EOS PREMIXED_FPV\n" <<
               "EOS NONPREMIXED_FPV\n" <<
               "EOS IDEAL_GAS_LSP");
        }
      }
    }

    CTI_Finalize();
  }
  catch (int e) {
    if (e >= 0) {
      CTI_Finalize();
    }
    else {
      CTI_Abort();
    }
  }
  catch(...) {
    CTI_Abort();
  }

  return 0;

}
