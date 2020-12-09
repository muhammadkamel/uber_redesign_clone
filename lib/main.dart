import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'pages/home.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarColor: Colors.orange,
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _markers = HashSet<Marker>(); //collection
  Future<void> _onMapCreated(GoogleMapController controller) async {
    // final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('1'),
        position: LatLng(29.990940, 31.149248),
        infoWindow: InfoWindow(
          title: 'Title',
          snippet: 'Address',
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        // backgroundColor: Colors.pink,
        // brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Google Office Locations'),
      //     backgroundColor: Colors.green[700],
      //   ),
      //   body: GoogleMap(
      //     onMapCreated: _onMapCreated,
      //     initialCameraPosition: CameraPosition(
      //       target: const LatLng(29.990940, 31.149248),
      //       zoom: 2,
      //     ),
      //     // markers: _markers.values.toSet(),
      //   ),
      // ),
    );
  }
}
