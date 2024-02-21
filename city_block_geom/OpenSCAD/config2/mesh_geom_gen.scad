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
	translate(v = [0, 38.666666666666664, 0]) {
		cube(center = true, size = [1856.0, 77.33333333333333, 1392.0]);
	}
	rotate(a = [0, 45, 0]) {
		translate(v = [-116.0, 0, -116.0]) {
			union() {
				translate(v = [6.0, 0, 8.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [-2.0, 0, 32.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [6.0, 0, 56.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [-2.0, 0, 80.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [6.0, 0, 104.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [22.0, 0, 8.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [14.0, 0, 32.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [22.0, 0, 56.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [14.0, 0, 80.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [22.0, 0, 104.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [38.0, 0, 8.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [30.0, 0, 32.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [38.0, 0, 56.0]) {
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
				translate(v = [30.0, 0, 80.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [38.0, 0, 104.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [54.0, 0, 8.0]) {
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
					}
				}
				translate(v = [46.0, 0, 32.0]) {
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
					}
				}
				translate(v = [54.0, 0, 56.0]) {
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
					}
				}
				translate(v = [46.0, 0, 80.0]) {
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
					}
				}
				translate(v = [54.0, 0, 104.0]) {
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
					}
				}
				translate(v = [70.0, 0, 8.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [62.0, 0, 32.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [70.0, 0, 56.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [62.0, 0, 80.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [70.0, 0, 104.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [86.0, 0, 8.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [78.0, 0, 32.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [86.0, 0, 56.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [78.0, 0, 80.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [86.0, 0, 104.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [102.0, 0, 8.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [94.0, 0, 32.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [102.0, 0, 56.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [94.0, 0, 80.0]) {
					union() {
						cube(size = [12, 3, 8]);
						translate(v = [6.0, 3, 4.0]) {
							xrot(a = -90) {
								prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
							}
						}
					}
				}
				translate(v = [102.0, 0, 104.0]) {
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
						translate(v = [6.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [30.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 56.0]) {
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
						translate(v = [30.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [54.0, 0, 8.0]) {
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
							}
						}
						translate(v = [46.0, 0, 32.0]) {
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
							}
						}
						translate(v = [54.0, 0, 56.0]) {
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
							}
						}
						translate(v = [46.0, 0, 80.0]) {
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
							}
						}
						translate(v = [54.0, 0, 104.0]) {
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
							}
						}
						translate(v = [70.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 104.0]) {
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
						translate(v = [6.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [30.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 56.0]) {
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
						translate(v = [30.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [54.0, 0, 8.0]) {
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
							}
						}
						translate(v = [46.0, 0, 32.0]) {
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
							}
						}
						translate(v = [54.0, 0, 56.0]) {
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
							}
						}
						translate(v = [46.0, 0, 80.0]) {
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
							}
						}
						translate(v = [54.0, 0, 104.0]) {
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
							}
						}
						translate(v = [70.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 104.0]) {
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
						translate(v = [6.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [30.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 56.0]) {
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
						translate(v = [30.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [54.0, 0, 8.0]) {
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
							}
						}
						translate(v = [46.0, 0, 32.0]) {
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
							}
						}
						translate(v = [54.0, 0, 56.0]) {
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
							}
						}
						translate(v = [46.0, 0, 80.0]) {
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
							}
						}
						translate(v = [54.0, 0, 104.0]) {
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
							}
						}
						translate(v = [70.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 104.0]) {
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
				translate(v = [232.0, 0, 0]) {
					union() {
						translate(v = [6.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [30.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 56.0]) {
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
						translate(v = [30.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [54.0, 0, 8.0]) {
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
							}
						}
						translate(v = [46.0, 0, 32.0]) {
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
							}
						}
						translate(v = [54.0, 0, 56.0]) {
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
							}
						}
						translate(v = [46.0, 0, 80.0]) {
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
							}
						}
						translate(v = [54.0, 0, 104.0]) {
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
							}
						}
						translate(v = [70.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
				}
				translate(v = [0, 0, 232.0]) {
					union() {
						translate(v = [6.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [30.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 56.0]) {
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
						translate(v = [30.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [54.0, 0, 8.0]) {
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
							}
						}
						translate(v = [46.0, 0, 32.0]) {
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
							}
						}
						translate(v = [54.0, 0, 56.0]) {
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
							}
						}
						translate(v = [46.0, 0, 80.0]) {
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
							}
						}
						translate(v = [54.0, 0, 104.0]) {
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
							}
						}
						translate(v = [70.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
				}
				translate(v = [232.0, 0, 232.0]) {
					union() {
						translate(v = [6.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [-2.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [6.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [14.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [22.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [30.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 56.0]) {
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
						translate(v = [30.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [38.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [54.0, 0, 8.0]) {
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
							}
						}
						translate(v = [46.0, 0, 32.0]) {
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
							}
						}
						translate(v = [54.0, 0, 56.0]) {
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
							}
						}
						translate(v = [46.0, 0, 80.0]) {
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
							}
						}
						translate(v = [54.0, 0, 104.0]) {
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
							}
						}
						translate(v = [70.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [62.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [70.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [78.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [86.0, 0, 104.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 8.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 32.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 56.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [94.0, 0, 80.0]) {
							union() {
								cube(size = [12, 3, 8]);
								translate(v = [6.0, 3, 4.0]) {
									xrot(a = -90) {
										prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
									}
								}
							}
						}
						translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
								translate(v = [6.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [-2.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [6.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [14.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [22.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [30.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 56.0]) {
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
								translate(v = [30.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [38.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [54.0, 0, 8.0]) {
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
									}
								}
								translate(v = [46.0, 0, 32.0]) {
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
									}
								}
								translate(v = [54.0, 0, 56.0]) {
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
									}
								}
								translate(v = [46.0, 0, 80.0]) {
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
									}
								}
								translate(v = [54.0, 0, 104.0]) {
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
									}
								}
								translate(v = [70.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [62.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [70.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [78.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [86.0, 0, 104.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 8.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 32.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 56.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [94.0, 0, 80.0]) {
									union() {
										cube(size = [12, 3, 8]);
										translate(v = [6.0, 3, 4.0]) {
											xrot(a = -90) {
												prismoid(h = 3, size1 = [12, 8], size2 = [8.0, 0]);
											}
										}
									}
								}
								translate(v = [102.0, 0, 104.0]) {
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
				}
			}
		}
	}
}
