// General Constants
const double domain_length = 348;
const double domain_height = domain_length / 3;
const double building_height = 6;
const double u_ref_4mps = 6.826;
const double uStar_ref_4mps = 0.4958;
      
// Initializaton constants
const double z0 = 0.366;
const double disp = 1.11*building_height;
const double vK_const = 0.41;
const double H_scaled = domain_height - disp;
// const double u_bulk = uStar/vK_const*(H_scaled*log(H_scaled/z0) - H_scaled + 1)/domain_height;

// Momentum Source Constants (PI Control)
const double xi = 0.707;
const double w_n = 0.1;

// Check For Indoor Cells
const int scalarSeedStep = 40000;
const int tempInitStep = scalarSeedStep + 80000;
const int delTempOutdoors = -5;
bool isPointIndoors(double x, double y, double z) {

    if (y >= 0 && y <= 3.0) {
        if (x >= 60.0 && x <= 72.0 &&
            z >= 86.0 && z <= 94.0) {
            return true;
        }
        if (x >= 84.0 && x <= 96.0 &&
            z >= 14.0 && z <= 22.0) {
            return true;
        }
        if (x >= 72.0 && x <= 84.0 &&
            z >= 50.0 && z <= 58.0) {
            return true;
        }
        if (x >= 84.0 && x <= 96.0 &&
            z >= 86.0 && z <= 94.0) {
            return true;
        }
        if (x >= 72.0 && x <= 84.0 &&
            z >= 122.0 && z <= 130.0) {
            return true;
        }
        if (x >= 84.0 && x <= 96.0 &&
            z >= 158.0 && z <= 166.0) {
            return true;
        }
        if (x >= -94.0 && x <= -86.0 &&
            z >= 60.0 && z <= 72.0) {
            return true;
        }
        if (x >= -22.0 && x <= -14.0 &&
            z >= 84.0 && z <= 96.0) {
            return true;
        }
        if (x >= -58.0 && x <= -50.0 &&
            z >= 72.0 && z <= 84.0) {
            return true;
        }
        if (x >= -94.0 && x <= -86.0 &&
            z >= 84.0 && z <= 96.0) {
            return true;
        }
        if (x >= -130.0 && x <= -122.0 &&
            z >= 72.0 && z <= 84.0) {
            return true;
        }
        if (x >= -166.0 && x <= -158.0 &&
            z >= 84.0 && z <= 96.0) {
            return true;
        }
        if (x >= 86.0 && x <= 94.0 &&
            z >= -72.0 && z <= -60.0) {
            return true;
        }
        if (x >= 14.0 && x <= 22.0 &&
            z >= -96.0 && z <= -84.0) {
            return true;
        }
        if (x >= 50.0 && x <= 58.0 &&
            z >= -84.0 && z <= -72.0) {
            return true;
        }
        if (x >= 86.0 && x <= 94.0 &&
            z >= -96.0 && z <= -84.0) {
            return true;
        }
        if (x >= 122.0 && x <= 130.0 &&
            z >= -84.0 && z <= -72.0) {
            return true;
        }
        if (x >= 158.0 && x <= 166.0 &&
            z >= -96.0 && z <= -84.0) {
            return true;
        }
        if (x >= -72.0 && x <= -60.0 &&
            z >= -94.0 && z <= -86.0) {
            return true;
        }
        if (x >= -96.0 && x <= -84.0 &&
            z >= -22.0 && z <= -14.0) {
            return true;
        }
        if (x >= -84.0 && x <= -72.0 &&
            z >= -58.0 && z <= -50.0) {
            return true;
        }
        if (x >= -96.0 && x <= -84.0 &&
            z >= -94.0 && z <= -86.0) {
            return true;
        }
        if (x >= -84.0 && x <= -72.0 &&
            z >= -130.0 && z <= -122.0) {
            return true;
        }
        if (x >= -96.0 && x <= -84.0 &&
            z >= -166.0 && z <= -158.0) {
            return true;
        }
    }
    return false;
}