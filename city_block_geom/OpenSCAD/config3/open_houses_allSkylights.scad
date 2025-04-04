include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/version.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/constants.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/transforms.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/distributors.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/mutators.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/color.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/attachments.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/shapes3d.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/shapes2d.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/drawing.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/masks3d.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/masks2d.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/math.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/paths.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/lists.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/comparisons.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/linalg.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/trigonometry.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/vectors.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/affine.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/coords.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/geometry.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/regions.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/strings.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/skin.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/vnf.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/utility.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/bosl2/BOSL2/partitions.scad>;

difference() {
	union() {
		translate(v = [12.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [0.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [12.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [0.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [12.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [36.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [24.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [36.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [24.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [36.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [60.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [48.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [60.0, 0, 86.0]) {
			difference() {
				union() {
					cube(size = [12, 3, 8]);
					translate(v = [6.0, 3, 4.0]) {
						xrot(a = -90) {
							prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
						}
					}
				}
				union() {
					translate(v = [0.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [0.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
				}
				translate(v = [4, 1.5, 6.0]) {
					cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
				}
				union() {
					translate(v = [0.05, 1.5, 2.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [0.05, 1.5, 6.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
				}
				translate(v = [10.0, 1.5, 4]) {
					cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
				}
				union() {
					translate(v = [2.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [2.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
				}
			}
		}
		translate(v = [48.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [60.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [84.0, 0, 14.0]) {
			difference() {
				union() {
					cube(size = [12, 3, 8]);
					translate(v = [6.0, 3, 4.0]) {
						xrot(a = -90) {
							prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
						}
					}
				}
				union() {
					translate(v = [0.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [0.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
				}
				translate(v = [4, 1.5, 6.0]) {
					cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
				}
				union() {
					translate(v = [0.05, 1.5, 2.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [0.05, 1.5, 6.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
				}
				translate(v = [10.0, 1.5, 4]) {
					cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
				}
				union() {
					translate(v = [2.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [2.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
				}
			}
		}
		translate(v = [72.0, 0, 50.0]) {
			difference() {
				union() {
					cube(size = [12, 3, 8]);
					translate(v = [6.0, 3, 4.0]) {
						xrot(a = -90) {
							prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
						}
					}
				}
				union() {
					translate(v = [0.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [0.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
				}
				translate(v = [4, 1.5, 6.0]) {
					cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
				}
				union() {
					translate(v = [0.05, 1.5, 2.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [0.05, 1.5, 6.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
				}
				translate(v = [10.0, 1.5, 4]) {
					cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
				}
				union() {
					translate(v = [2.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [2.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
				}
			}
		}
		translate(v = [84.0, 0, 86.0]) {
			difference() {
				union() {
					cube(size = [12, 3, 8]);
					translate(v = [6.0, 3, 4.0]) {
						xrot(a = -90) {
							prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
						}
					}
				}
				union() {
					translate(v = [0.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [0.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
				}
				translate(v = [4, 1.5, 6.0]) {
					cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
				}
				union() {
					translate(v = [0.05, 1.5, 2.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [0.05, 1.5, 6.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
				}
				translate(v = [10.0, 1.5, 4]) {
					cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
				}
				union() {
					translate(v = [2.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [2.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
				}
			}
		}
		translate(v = [72.0, 0, 122.0]) {
			difference() {
				union() {
					cube(size = [12, 3, 8]);
					translate(v = [6.0, 3, 4.0]) {
						xrot(a = -90) {
							prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
						}
					}
				}
				union() {
					translate(v = [0.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [0.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
				}
				translate(v = [4, 1.5, 6.0]) {
					cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
				}
				union() {
					translate(v = [0.05, 1.5, 2.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [0.05, 1.5, 6.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
				}
				translate(v = [10.0, 1.5, 4]) {
					cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
				}
				union() {
					translate(v = [2.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [2.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
				}
			}
		}
		translate(v = [84.0, 0, 158.0]) {
			difference() {
				union() {
					cube(size = [12, 3, 8]);
					translate(v = [6.0, 3, 4.0]) {
						xrot(a = -90) {
							prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
						}
					}
				}
				union() {
					translate(v = [0.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [0.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [4.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 0.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
					translate(v = [8.1, 0.1, 4.1]) {
						cube(center = false, size = [3.8, 2.8, 3.8]);
					}
				}
				translate(v = [4, 1.5, 6.0]) {
					cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
				}
				union() {
					translate(v = [0.05, 1.5, 2.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [0.05, 1.5, 6.0]) {
						cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
					}
					translate(v = [2.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [6.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 0.05]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
					translate(v = [10.0, 1.5, 7.95]) {
						cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
					}
				}
				translate(v = [10.0, 1.5, 4]) {
					cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
				}
				union() {
					translate(v = [2.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [2.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [6.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 2.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
					translate(v = [10.0, 2.95, 6.0]) {
						union() {
							cube(center = true, size = [0.75, 0.1, 0.75]);
							cube(center = true, size = [0.75, 3.75, 0.75]);
						}
					}
				}
			}
		}
		translate(v = [108.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [96.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [108.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [96.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [108.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [132.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [120.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [132.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [120.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [132.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [156.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [144.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [156.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [144.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		translate(v = [156.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0, 3, 4.0]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
					}
				}
			}
		}
		rotate(a = [0, -90, 0]) {
			union() {
				translate(v = [12.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [48.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 86.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [48.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [84.0, 0, 14.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [72.0, 0, 50.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [84.0, 0, 86.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [72.0, 0, 122.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [84.0, 0, 158.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [108.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
			}
		}
		rotate(a = [0, 90, 0]) {
			union() {
				translate(v = [12.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [48.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 86.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [48.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [84.0, 0, 14.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [72.0, 0, 50.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [84.0, 0, 86.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [72.0, 0, 122.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [84.0, 0, 158.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [108.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
			}
		}
		rotate(a = [0, 180, 0]) {
			union() {
				translate(v = [12.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [48.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 86.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [48.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [84.0, 0, 14.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [72.0, 0, 50.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [84.0, 0, 86.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [72.0, 0, 122.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [84.0, 0, 158.0]) {
					difference() {
						union() {
							cube(size = [12, 3, 8]);
							translate(v = [6.0, 3, 4.0]) {
								xrot(a = -90) {
									prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
								}
							}
						}
						union() {
							translate(v = [0.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [0.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [4.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 0.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
							translate(v = [8.1, 0.1, 4.1]) {
								cube(center = false, size = [3.8, 2.8, 3.8]);
							}
						}
						translate(v = [4, 1.5, 6.0]) {
							cube(center = true, size = [0.22000000000000003, 2.25, 0.75]);
						}
						union() {
							translate(v = [0.05, 1.5, 2.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [0.05, 1.5, 6.0]) {
								cube(center = true, size = [0.11000000000000001, 0.75, 0.75]);
							}
							translate(v = [2.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [6.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 0.05]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
							translate(v = [10.0, 1.5, 7.95]) {
								cube(center = true, size = [0.75, 0.75, 0.11000000000000001]);
							}
						}
						translate(v = [10.0, 1.5, 4]) {
							cube(center = true, size = [3.8, 2.8, 0.22000000000000003]);
						}
						union() {
							translate(v = [2.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [2.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [6.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 2.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
							translate(v = [10.0, 2.95, 6.0]) {
								union() {
									cube(center = true, size = [0.75, 0.1, 0.75]);
									cube(center = true, size = [0.75, 3.75, 0.75]);
								}
							}
						}
					}
				}
				translate(v = [108.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
			}
		}
	}
	translate(v = [0, 5.699999999999999, 0]) {
		cube(center = true, size = [348.0, 6, 348.0]);
	}
}
