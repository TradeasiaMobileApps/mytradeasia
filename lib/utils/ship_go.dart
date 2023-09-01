import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mytradeasia/utils/theme.dart';

class ShipGoScreen extends StatelessWidget {
  ShipGoScreen({super.key});

  final double latitude = 777.9;
  final double longitude = 777.9;

  final routeData = [
    [8.729543549999999, -79.61291045000002],
    [8.943615, -79.545929],
    [9.0070242, -79.59980015000002],
    [9.3029338, -79.85119885],
    [9.366343, -79.90507000000002],
    [10.99826245, -79.04075110000002],
    [18.61388655, -75.0072629],
    [20.245806, -74.142944],
    [21.998333337490987, -75.16153650059721],
    [30.176794245782254, -79.91496817005077],
    [31.92932158327324, -80.93356067064792],
    [32.08354, -81.09983]
  ];

  final seaRoutes = [
    [51.22047, 4.400260000000003],
    [51.34122410356018, 4.349611577822486],
    [51.90474325350768, 4.113252274327465],
    [52.02549735706786, 4.062603852149948],
    [52.020467886132245, 4.028116051448592],
    [51.996997021766035, 3.867172981508844],
    [51.99196755083042, 3.8326851808074593],
    [51.65235156820585, 2.9667782036863457],
    [50.067476982624555, -1.0741210228788702],
    [49.727861, -1.9400280000000123],
    [49.54469854999999, -2.366040450000014],
    [48.689940449999995, -4.354098550000003],
    [48.506778, -4.780111000000005],
    [46.89650295, -7.833906850000005],
    [39.38188605, -22.084954149999987],
    [37.771611, -25.138750000000016],
    [33.54834435, -33.31158744999999],
    [13.839766650000001, -71.45149555],
    [9.6165, -79.624333],
    [9.57897645, -79.66644355],
    [9.40386655, -79.86295944999999],
    [9.366343, -79.90507],
    [9.3029338, -79.85119885],
    [9.0070242, -79.59980015],
    [8.943615, -79.545929],
    [7.44394365, -79.75072714999999],
    [0.44547734999999977, -80.70645185],
    [-1.054194, -80.91125],
    [-1.5369441, -80.96287504999998],
    [-3.7897779000000003, -81.20379194999998],
    [-4.272528, -81.255417],
    [-4.52852385, -81.23992529999998],
    [-5.72317115, -81.16763069999999],
    [-5.979167, -81.152139],
    [-10.126166900000001, -79.72213905],
    [-29.4788331, -73.04880595],
    [-33.625833, -71.618806],
    [-33.62122932095881, -71.61895928581441],
    [-33.59974548543325, -71.61967461961495],
    [-33.595141806392064, -71.61982790542936],
    [-33.595080035433256, -71.61797271961495],
    [-33.59479177095881, -71.60931518581441],
    [-33.59473, -71.60746]
  ];

  @override
  Widget build(BuildContext context) {
    List<LatLng> latlng = [];
    seaRoutes.forEach((element) {
      latlng.add(LatLng(element[0], element[1]));
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: greyColor,
        title: const Text(
          "Ships Go Tracking",
          style: TextStyle(color: blackColor),
        ),
      ),
      body: FlutterMap(
        nonRotatedChildren: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution('OpenStreetMap contributors', onTap: () {}),
            ],
          ),
        ],
        options:
            MapOptions(center: latlng.elementAt(latlng.length ~/ 2), zoom: 1.5),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                  points: latlng,
                  color: Colors.blue,
                  strokeWidth: 3,
                  isDotted: true),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: latlng.first,
                builder: (context) {
                  return const Icon(Icons.location_on, color: Colors.red);
                },
              ),
              Marker(
                point: latlng.elementAt(latlng.length ~/ 2),
                builder: (context) {
                  return const Icon(Icons.directions_boat,
                      color: Colors.deepOrangeAccent);
                },
              ),
              Marker(
                point: latlng.last,
                builder: (context) {
                  return const Icon(Icons.location_on, color: Colors.blue);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
