import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  static const routeName = 'Map';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMapController? mapController;
  static const latLng = LatLng(37.810575, -122.477174);
  static const streetStyle =
      'mapbox://styles/atinyflame/cl0d8zhwn004816qhocvzc2ch';
  static const cianStyle =
      'mapbox://styles/atinyflame/cl0d8x6lb000q14ntfnko7qzs';

  var selectedStyle = streetStyle;

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        styleString: selectedStyle,
        accessToken: dotenv.env['publicToken'],
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: latLng,
          zoom: 14,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            selectedStyle =
                selectedStyle == streetStyle ? cianStyle : streetStyle;
          });
        },
        child: const Icon(Icons.add_to_home_screen),
      ),
    );
  }
}
