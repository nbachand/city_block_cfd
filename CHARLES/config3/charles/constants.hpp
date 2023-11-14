// General Constants
const double domain_height = 116;
const double domain_length = 348;
const double building_height = 6;
      
// Initializaton constants
const double z0 = 0.366;
const double disp = 1.11*building_height;
const double vK_const = 0.41;
const double H_scaled = domain_height - disp;
const double u_bulk = uStar/vK_const*(H_scaled*log(H_scaled/z0) - H_scaled + 1)/domain_height;

// Momentum Source Constants (PI Control)
const double xi = 0.707;
const double w_n = 0.1;
