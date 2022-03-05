import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  static const routeName = 'Map';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMapController? mapController;
  static const center = LatLng(37.810575, -122.477174);
  static const streetStyle =
      'mapbox://styles/atinyflame/cl0d8zhwn004816qhocvzc2ch';
  static const cianStyle =
      'mapbox://styles/atinyflame/cl0d8x6lb000q14ntfnko7qzs';

  var selectedStyle = cianStyle;

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/symbols/custom-icon.png");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController!.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        onStyleLoadedCallback: _onStyleLoaded,
        styleString: selectedStyle,
        accessToken: dotenv.env['publicToken'],
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: center,
          zoom: 14,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Symbols
          FloatingActionButton(
            onPressed: () {
              setState(() {
                mapController?.addSymbol(
                  const SymbolOptions(
                    // textColor: '#cccccc',
                    geometry: center,
                    textField: 'Symbol added here',
                    iconImage: 'networkImage',
                    // iconSize: 3,
                    textOffset: Offset(0, 2),
                  ),
                );
              });
            },
            child: const Icon(Icons.signpost_sharp),
          ),
          const SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                mapController?.animateCamera(CameraUpdate.zoomIn());
              });
            },
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                mapController?.animateCamera(CameraUpdate.zoomOut());
              });
            },
            child: const Icon(Icons.zoom_out),
          ),
          const SizedBox(
            height: 5,
          ),

          // Change Style
          FloatingActionButton(
            onPressed: () {
              setState(() {
                selectedStyle =
                    selectedStyle == streetStyle ? cianStyle : streetStyle;
              });
            },
            child: const Icon(Icons.change_circle),
          ),
        ],
      ),
    );
  }
}
