import locations.tools as tools

tiles = {}
x_spacings = [1,3,5]

for i in range(len(x_spacings)):
    x_dist = x_spacings[i]*80/6
    tiles[i] = tools.y_col(x_dist,80,[0,160],161)
    tools.writeProbes(tiles[i], f"./CHARLES/probes/locations/x_{x_spacings[i]}over6.txt")
