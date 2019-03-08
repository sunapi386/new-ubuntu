# Tools for mapping

Generating lidar maps.

## Tools I've been using daily 

-  [Potree](http://potree.entwine.io/data/custom.html?r=) for visualizing points
-  [PDAL](https://pdal.io) building LAZ files from lidar/RTK dumps, with the [laz-perf](https://github.com/hobu/laz-perf) and [LASzip](https://github.com/LASzip/LASzip) plugins. The RTK data is captured in Lat/Lng and forwarded to UTM using [GeographicLib](https://geographiclib.sourceforge.io)
-  [Entwine](https://entwine.io) building EPT folder directory to serve to Potree
-  Clion for editing C++

## Tools I occasionally use or would find useful

-  [Greyhound](https://greyhound.io) for serving the EPT files in a queriable API. Seems deprecated, so I'm not really sure what's going on with this project. But when the time comes that I need to make bounding box data queries, I'll look into this. Or look into using the [PDAL EPT reader](https://pdal.io/stages/readers.ept.html).
-  [PCL](http://pointclouds.org/) for handling point cloud data in abstract. I'm already using this thru PDAL.
-  [GDAL](https://www.gdal.org) also already using thru PDAL.
-  [GeoWave](https://locationtech.github.io/geowave/) and [GeoMesa](https://geomesa.org/documentation/tutorials/index.html) for data store. But I'm not using this at the moment for lack of an adapter to Potree. I very much like my data visualizable. But I could store a lot of points here, potentially. But seems maybe not so ideal for point cloud points data. Potentially [TileDB](https://tiledb.io) can be a better choice. But not really looking in the data store right now. 

## Cool tools I want to check out more

These tools may be small, but that follows the Unix philosophy: do one thing and do it well.

-  [Hexer](http://github.com/hobu/hexer) for cool visualization of where I have collected data before, and how dense my data is.
-  [Points2Grid](https://github.com/CRREL/points2grid) generate a digital elevation model from points. I could have another way of doing this already with PDAL. 
-  [Ceres-Solver](https://github.com/ceres-solver/ceres-solver) A large scale non-linear optimization library from Google. To do things like pose graph optimization for localization.
