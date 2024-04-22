include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/version.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/constants.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/transforms.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/distributors.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/mutators.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/color.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/attachments.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/shapes3d.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/shapes2d.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/drawing.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/masks3d.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/masks2d.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/math.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/paths.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/lists.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/comparisons.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/linalg.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/trigonometry.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/vectors.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/affine.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/coords.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/geometry.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/regions.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/strings.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/skin.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/vnf.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/utility.scad>;
include </opt/homebrew/Caskroom/miniconda/base/envs/pycascade/lib/python3.10/site-packages/solid2/extensions/../libs/BOSL2/partitions.scad>;





difference() {
	translate(v = [0, 58.0, 0]) {
		cube(center = true, size = [348.0, 116.0, 348.0]);
	}
	union() {
		translate(v = [12.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [0.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [12.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [0.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [12.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [36.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [24.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [36.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [24.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [36.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [60.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [48.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [60.0, 0, 86.0]) {
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
					translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
				}
				translate(v = [4, 1.5000000000, 6.0000000000]) {
					cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
				}
				union() {
					translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
				}
				translate(v = [10.0000000000, 1.5000000000, 4]) {
					cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
				}
				union() {
					translate(v = [2.0000000000, 2.9500000000, 2.0000000000]) {
						union() {
							cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
							cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
						}
					}
					translate(v = [2.0000000000, 2.9500000000, 6.0000000000]) {
						union() {
							cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
							cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
						}
					}
					translate(v = [6.0000000000, 2.9500000000, 2.0000000000]) {
						union() {
							cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
							cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
						}
					}
					translate(v = [6.0000000000, 2.9500000000, 6.0000000000]) {
						union() {
							cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
							cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
						}
					}
					translate(v = [10.0000000000, 2.9500000000, 2.0000000000]) {
						union() {
							cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
							cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
						}
					}
					translate(v = [10.0000000000, 2.9500000000, 6.0000000000]) {
						union() {
							cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
							cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
						}
					}
				}
			}
		}
		translate(v = [48.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [60.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [84.0, 0, 14.0]) {
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
					translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
				}
				translate(v = [4, 1.5000000000, 6.0000000000]) {
					cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
				}
				union() {
					translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
				}
				translate(v = [10.0000000000, 1.5000000000, 4]) {
					cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
				}
			}
		}
		translate(v = [72.0, 0, 50.0]) {
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
					translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
				}
				translate(v = [4, 1.5000000000, 6.0000000000]) {
					cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
				}
				union() {
					translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
				}
				translate(v = [10.0000000000, 1.5000000000, 4]) {
					cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
				}
			}
		}
		translate(v = [84.0, 0, 86.0]) {
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
					translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
				}
				translate(v = [4, 1.5000000000, 6.0000000000]) {
					cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
				}
				union() {
					translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
				}
				translate(v = [10.0000000000, 1.5000000000, 4]) {
					cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
				}
			}
		}
		translate(v = [72.0, 0, 122.0]) {
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
					translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
				}
				translate(v = [4, 1.5000000000, 6.0000000000]) {
					cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
				}
				union() {
					translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
				}
				translate(v = [10.0000000000, 1.5000000000, 4]) {
					cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
				}
			}
		}
		translate(v = [84.0, 0, 158.0]) {
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
					translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
					translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
						cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
					}
				}
				translate(v = [4, 1.5000000000, 6.0000000000]) {
					cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
				}
				union() {
					translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
						cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
					}
					translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
					translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
						cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
					}
				}
				translate(v = [10.0000000000, 1.5000000000, 4]) {
					cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
				}
			}
		}
		translate(v = [108.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [96.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [108.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [96.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [108.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [132.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [120.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [132.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [120.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [132.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [156.0, 0, 14.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [144.0, 0, 50.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [156.0, 0, 86.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [144.0, 0, 122.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		translate(v = [156.0, 0, 158.0]) {
			union() {
				cube(size = [12, 3, 8]);
				translate(v = [6.0000000000, 3, 4.0000000000]) {
					xrot(a = -90) {
						prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
					}
				}
			}
		}
		rotate(a = [0, -90, 0]) {
			union() {
				translate(v = [12.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [48.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 86.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
						union() {
							translate(v = [2.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [2.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [6.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [6.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [10.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [10.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
						}
					}
				}
				translate(v = [48.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [84.0, 0, 14.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [72.0, 0, 50.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [84.0, 0, 86.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [72.0, 0, 122.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [84.0, 0, 158.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [108.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 158.0]) {
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
		rotate(a = [0, 90, 0]) {
			union() {
				translate(v = [12.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [48.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 86.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
						union() {
							translate(v = [2.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [2.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [6.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [6.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [10.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [10.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
						}
					}
				}
				translate(v = [48.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [84.0, 0, 14.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [72.0, 0, 50.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [84.0, 0, 86.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [72.0, 0, 122.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [84.0, 0, 158.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [108.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 158.0]) {
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
		rotate(a = [0, 180, 0]) {
			union() {
				translate(v = [12.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [0.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [12.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [24.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [36.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [48.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 86.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
						union() {
							translate(v = [2.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [2.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [6.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [6.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [10.0000000000, 2.9500000000, 2.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
							translate(v = [10.0000000000, 2.9500000000, 6.0000000000]) {
								union() {
									cube(center = true, size = [0.7500000000, 0.1000000000, 0.7500000000]);
									cube(center = true, size = [0.7500000000, 3.6000000000, 0.7500000000]);
								}
							}
						}
					}
				}
				translate(v = [48.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [60.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [84.0, 0, 14.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [72.0, 0, 50.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [84.0, 0, 86.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [72.0, 0, 122.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [84.0, 0, 158.0]) {
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
							translate(v = [0.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [0.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [4.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 0.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
							translate(v = [8.1000000000, 0.1000000000, 4.1000000000]) {
								cube(center = false, size = [3.8000000000, 2.8000000000, 3.8000000000]);
							}
						}
						translate(v = [4, 1.5000000000, 6.0000000000]) {
							cube(center = true, size = [0.2200000000, 2.2500000000, 0.7500000000]);
						}
						union() {
							translate(v = [0.0500000000, 1.5000000000, 2.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [0.0500000000, 1.5000000000, 6.0000000000]) {
								cube(center = true, size = [0.1100000000, 0.7500000000, 0.7500000000]);
							}
							translate(v = [2.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [6.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 0.0500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
							translate(v = [10.0000000000, 1.5000000000, 7.9500000000]) {
								cube(center = true, size = [0.7500000000, 0.7500000000, 0.1100000000]);
							}
						}
						translate(v = [10.0000000000, 1.5000000000, 4]) {
							cube(center = true, size = [3.8000000000, 2.8000000000, 0.2200000000]);
						}
					}
				}
				translate(v = [108.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [96.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [108.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [120.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [132.0, 0, 158.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 14.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 50.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 86.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [144.0, 0, 122.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0000000000, 3, 4.0000000000]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0000000000, 0]);
							}
						}
					}
				}
				translate(v = [156.0, 0, 158.0]) {
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
	}
}
