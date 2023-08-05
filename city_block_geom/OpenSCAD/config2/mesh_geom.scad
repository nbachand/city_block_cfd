include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/version.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/constants.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/transforms.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/distributors.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/mutators.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/color.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/attachments.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/shapes3d.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/shapes2d.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/drawing.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/masks3d.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/masks2d.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/math.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/paths.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/lists.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/comparisons.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/linalg.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/trigonometry.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/vectors.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/affine.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/coords.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/geometry.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/regions.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/strings.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/skin.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/vnf.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/utility.scad>;
include </home/groups/gorle/codes/miniconda3/envs/pycascade/lib/python3.11/site-packages/solid2/extensions/bosl2/BOSL2/partitions.scad>;





difference() {
	cube(size = [192, 64.0000000000, 192]);
	union() {
		translate(v = [-14.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [-6.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [-14.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [-6.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [-14.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [-6.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [-14.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [-6.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [2.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [10.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [2.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [10.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [2.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [10.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [2.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [10.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [18.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [26.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [18.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [26.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [18.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [26.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [18.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [26.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [34.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [42.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [34.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [42.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [34.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [42.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [34.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [42.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [50.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [58.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [50.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [58.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [50.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [58.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [50.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [58.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [66.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [74.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [66.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [74.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [66.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [74.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [66.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [74.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [82.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [90.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [82.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [90.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [82.0000000000, 0, 104.0000000000]) {
			difference() {
				union() {
					cube(size = [12, 3, 8]);
					translate(v = [6.0000000000, 3, 4.0000000000]) {
						xrot(a = -90) {
							prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
						}
					}
				}
				union() {
					translate(v = [0.0015, 0.0015, 0.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [0.0015, 0.0015, 4.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [4.0015, 0.0015, 0.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [4.0015, 0.0015, 4.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [8.0015, 0.0015, 0.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [8.0015, 0.0015, 4.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
				}
				translate(v = [4, 1.5000000000, 6.0000000000]) {
					cube(center = true, size = [0.006, 2.2500000000, 0.7500000000]);
				}
				union() {
					translate(v = [0, 1.5000000000, 2.0000000000]) {
						cube(center = true, size = [0.006, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 0]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [0, 1.5000000000, 6.0000000000]) {
						cube(center = true, size = [0.006, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 8]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [6.0000000000, 1.5000000000, 0]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [6.0000000000, 1.5000000000, 8]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [10.0000000000, 1.5000000000, 0]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [10.0000000000, 1.5000000000, 8]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
				}
				translate(v = [10.0000000000, 1.5000000000, 4]) {
					cube(center = true, size = [3.994, 2.994, 0.006]);
				}
				translate(v = [0, 0.1000000000, 0]) {
					union() {
						translate(v = [2.0000000000, 3, 2.0000000000]) {
							cube(center = true, size = [0.7500000000, 4.0000000000, 0.7500000000]);
						}
						translate(v = [2.0000000000, 3, 6.0000000000]) {
							cube(center = true, size = [0.7500000000, 4.0000000000, 0.7500000000]);
						}
						translate(v = [6.0000000000, 3, 2.0000000000]) {
							cube(center = true, size = [0.7500000000, 4.0000000000, 0.7500000000]);
						}
						translate(v = [6.0000000000, 3, 6.0000000000]) {
							cube(center = true, size = [0.7500000000, 4.0000000000, 0.7500000000]);
						}
						translate(v = [10.0000000000, 3, 2.0000000000]) {
							cube(center = true, size = [0.7500000000, 4.0000000000, 0.7500000000]);
						}
						translate(v = [10.0000000000, 3, 6.0000000000]) {
							cube(center = true, size = [0.7500000000, 4.0000000000, 0.7500000000]);
						}
					}
				}
			}
		}
		translate(v = [90.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [82.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [90.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [98.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [106.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [98.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [106.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [98.0000000000, 0, 104.0000000000]) {
			difference() {
				union() {
					cube(size = [12, 3, 8]);
					translate(v = [6.0000000000, 3, 4.0000000000]) {
						xrot(a = -90) {
							prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
						}
					}
				}
				union() {
					translate(v = [0.0015, 0.0015, 0.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [0.0015, 0.0015, 4.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [4.0015, 0.0015, 0.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [4.0015, 0.0015, 4.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [8.0015, 0.0015, 0.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
					translate(v = [8.0015, 0.0015, 4.0015]) {
						cube(center = false, size = [3.997, 2.997, 3.997]);
					}
				}
				translate(v = [4, 1.5000000000, 6.0000000000]) {
					cube(center = true, size = [0.006, 2.2500000000, 0.7500000000]);
				}
				union() {
					translate(v = [0, 1.5000000000, 2.0000000000]) {
						cube(center = true, size = [0.006, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 0]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [0, 1.5000000000, 6.0000000000]) {
						cube(center = true, size = [0.006, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 8]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [6.0000000000, 1.5000000000, 0]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [6.0000000000, 1.5000000000, 8]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [10.0000000000, 1.5000000000, 0]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
					translate(v = [10.0000000000, 1.5000000000, 8]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.006]);
					}
				}
				translate(v = [10.0000000000, 1.5000000000, 4]) {
					cube(center = true, size = [3.994, 2.994, 0.006]);
				}
			}
		}
		translate(v = [106.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [98.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [106.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [114.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [122.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [114.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [122.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [114.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [122.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [114.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [122.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [130.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [138.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [130.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [138.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [130.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [138.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [130.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [138.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [146.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [154.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [146.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [154.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [146.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [154.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [146.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [154.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [162.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [170.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [162.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [170.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [162.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [170.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [162.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [170.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [178.0000000000, 0, 8.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [186.0000000000, 0, 32.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [178.0000000000, 0, 56.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [186.0000000000, 0, 80.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [178.0000000000, 0, 104.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [186.0000000000, 0, 128.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [178.0000000000, 0, 152.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [186.0000000000, 0, 176.0000000000]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
	}
}
