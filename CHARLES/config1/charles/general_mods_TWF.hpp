
#include "FlowSolver.hpp"
#include "IdealGasSolver.hpp"
#include "PremixedSolver.hpp"
#include "IdealGasSolverWithLsp.hpp"
#include "HelmholtzSolver.hpp"
#include "NonpremixedSolver.hpp"
#include "BasicPostpro.hpp"
#include <tuple>
#include <iostream>
        
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
    
  // // General Constants
  // const double domain_height = 192;
  // const double domain_length = domain_height;
  // int ref_icv = 0;
  // double y_ref = 0.0;
  
  // General Constants
  const double domain_height;
  const double domain_length;
  
  MyHelmholtzSolver() : domain_height(192), domain_length(192) {}
        
  void initData() {

    HelmholtzSolver::initData();

  }

  ~MyHelmholtzSolver() {}
    
  
    
  std::tuple<double, double, double> findRefUVY(double building_height) {
    tuple<double, double, double> result;
    const double ref_window = building_height/5;
    bool stop = false;
    double u_t;
    double v_t;
    double y_ref;
      
    double x;
    double y;
    double z;
      
    int ref_icv;
    
    FOR_ICV {
      if (stop == false) {
        x = x_cv[icv][0];
        y = x_cv[icv][1];
        z = x_cv[icv][2];
        if (x >= domain_length/2-ref_window && x <= domain_length/2+ref_window){
          if (y >= 2*building_height-ref_window && y <= 2*building_height+ref_window){
            if (z >= domain_length/2-ref_window && z <= domain_length/2+ref_window){
              ref_icv = icv;
              u_t = u[ref_icv][0];
              v_t = u[ref_icv][2];
              y_ref = x_cv[ref_icv][1];
              // cout << ">>>>> found ref point with icv: " << icv << endl;
              // cout << "x_ref= " << x << " y_ref= " << y_ref << " z_ref= " << z << endl; 
              // stop = true;
            }
          }
        }
      } 
    }
    cout << ">>>>> u_t: " << u_t << ", y_ref: " << y_ref << endl;
    result = std::make_tuple(u_t, v_t, y_ref);
    return result;
  }
    
  void initialHook() {
    if (step == 0) {
      if ( mpi_rank == 0 ) 
        cout << ">>>>> specifying initial velocity field and Temp" << endl;
      
      // Initializaton constants
      const double uStar = 0.4958;
      const double z0 = 0.366;
      const double disp = 6.66;
      const double vK_const = 0.41;
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

        // const double u_parr = 2*(u_loglaw - u_bulk*(absy/domain_height));

        // u[icv][0] = u_parr*cos(theta_wind);
        // u[icv][2] = u_parr*sin(theta_wind);
        
        u[icv][0] = u_loglaw*cos(theta_wind)+.001;
        u[icv][2] = u_loglaw*sin(theta_wind)+.001;
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
    // Momentum constants
    // int ref_icv = 10;
    const double factor = momentum_scaling_factor;
    const double C_L = 0.5;
    const double C_t = 0.5;
    const double u_ct = 4.0*cos(theta_wind);
    const double v_ct = 4.0*sin(theta_wind);
    const double L_0 = C_L*domain_length;
    const double u_0 = u_ct; // this is the average velocity at the reference point
    const double dt_0 = C_t*domain_length/u_0; 
    
    const double building_height = 6;
    double u_t, v_t, y_ref;
    std::tie(u_t, v_t, y_ref) = this->findRefUVY(building_height);
    
    if ( step != 0){
      const double tau_t = dt_0 + (dt - dt_0)*exp(-time/dt_0);
      
      cout << ">>>>> y_ref: " << y_ref << endl;
      if ( mpi_rank == 0 ){
        cout << ">>>>> adding momentum source with tau " << tau_t << ", time = " << time << endl;
        cout << ">>>>> u_t is " << u_t << " (u_ct is " << u_ct << ")" << endl;
        cout << ">>>>> v_t is " << v_t << " (v_ct is " << v_ct << ")" << endl;
      }
  
//       FOR_ICV {
//         const double y = x_cv[icv][1]; 
//         const double S_u = (u_ct - u_t)/tau_t*exp(-.5*(y-y_ref)/L_0);
//         const double S_v = (v_ct - v_t)/tau_t*exp(-.5*(y-y_ref)/L_0);
//         // const double mom_source = factor*vol_cv[icv]*pow(uStar,2)/domain_height;
//         rhs[icv][0] += cos(theta_wind)*S_u;
//         rhs[icv][0] += sin(theta_wind)*S_v;
        
//         rhs[icv][2] += sin(theta_wind)*S_u;
//         rhs[icv][2] += cos(theta_wind)*S_v;
//         // if ( icv == ref_icv && mpi_rank == 0){
//         //   cout << ">>>>> U momentum source is " << S_u << endl;
//         //   cout << ">>>>> V momentum source is " << S_v << endl;
//         // }
//       }
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
