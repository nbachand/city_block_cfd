// Config Constants
const double domain_length = 232;
const double domain_height = domain_length / 3;
const double building_height = 6;
const double u_ref_4mps = 5.41;
const double uStar_ref_4mps = 0.4958;
      
bool isPointIndoors(double x, double y, double z) {

    if (y >= 0 && y <= 3.0) {
        if (x >= 38.0 && x <= 50.0 &&
            z >= 56.0 && z <= 64.0) {
            return true;
        }
        if (x >= 54.0 && x <= 66.0 &&
            z >= 8.0 && z <= 16.0) {
            return true;
        }
        if (x >= 46.0 && x <= 58.0 &&
            z >= 32.0 && z <= 40.0) {
            return true;
        }
        if (x >= 54.0 && x <= 66.0 &&
            z >= 56.0 && z <= 64.0) {
            return true;
        }
        if (x >= 46.0 && x <= 58.0 &&
            z >= 80.0 && z <= 88.0) {
            return true;
        }
        if (x >= 54.0 && x <= 66.0 &&
            z >= 104.0 && z <= 112.0) {
            return true;
        }
        if (x >= -64.0 && x <= -56.0 &&
            z >= 38.0 && z <= 50.0) {
            return true;
        }
        if (x >= -16.0 && x <= -8.0 &&
            z >= 54.0 && z <= 66.0) {
            return true;
        }
        if (x >= -40.0 && x <= -32.0 &&
            z >= 46.0 && z <= 58.0) {
            return true;
        }
        if (x >= -64.0 && x <= -56.0 &&
            z >= 54.0 && z <= 66.0) {
            return true;
        }
        if (x >= -88.0 && x <= -80.0 &&
            z >= 46.0 && z <= 58.0) {
            return true;
        }
        if (x >= -112.0 && x <= -104.0 &&
            z >= 54.0 && z <= 66.0) {
            return true;
        }
        if (x >= 56.0 && x <= 64.0 &&
            z >= -50.0 && z <= -38.0) {
            return true;
        }
        if (x >= 8.0 && x <= 16.0 &&
            z >= -66.0 && z <= -54.0) {
            return true;
        }
        if (x >= 32.0 && x <= 40.0 &&
            z >= -58.0 && z <= -46.0) {
            return true;
        }
        if (x >= 56.0 && x <= 64.0 &&
            z >= -66.0 && z <= -54.0) {
            return true;
        }
        if (x >= 80.0 && x <= 88.0 &&
            z >= -58.0 && z <= -46.0) {
            return true;
        }
        if (x >= 104.0 && x <= 112.0 &&
            z >= -66.0 && z <= -54.0) {
            return true;
        }
        if (x >= -50.0 && x <= -38.0 &&
            z >= -64.0 && z <= -56.0) {
            return true;
        }
        if (x >= -66.0 && x <= -54.0 &&
            z >= -16.0 && z <= -8.0) {
            return true;
        }
        if (x >= -58.0 && x <= -46.0 &&
            z >= -40.0 && z <= -32.0) {
            return true;
        }
        if (x >= -66.0 && x <= -54.0 &&
            z >= -64.0 && z <= -56.0) {
            return true;
        }
        if (x >= -58.0 && x <= -46.0 &&
            z >= -88.0 && z <= -80.0) {
            return true;
        }
        if (x >= -66.0 && x <= -54.0 &&
            z >= -112.0 && z <= -104.0) {
            return true;
        }
    }
    return false;
}
