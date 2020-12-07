import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var myMarkers = HashSet<Marker>(); //collection
  // BitmapDescriptor customMarker; //attribute
  List<Polyline> myPolyline = [];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    createPloyLine();
  }

  createPloyLine() {
    myPolyline.add(
      Polyline(
          polylineId: PolylineId('1'),
          color: Colors.blue,
          width: 3,
          points: [
            LatLng(29.990000, 31.149000),
            LatLng(29.999000, 31.149900),
          ],
          patterns: [
            PatternItem.dash(20),
            PatternItem.gap(10),
          ]),
    );
  }

  Set<Polygon> myPolygon() {
    var polygonCoords = List<LatLng>();
    // polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));
    // polygonCoords.add(LatLng(37.43006265331129, -122.08832357078792));
    // polygonCoords.add(LatLng(37.43006265331129, -122.08332357078792));
    // polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));

    var polygonSet = Set<Polygon>();
    polygonSet.add(
      Polygon(
        polygonId: PolygonId('1'),
        points: polygonCoords,
        strokeWidth: 1,
        strokeColor: Colors.red,
      ),
    );

    return polygonSet;
  }

  Set<Circle> myCircles = Set.from([
    Circle(
      circleId: CircleId('1'),
      center: LatLng(29.990940, 31.149248),
      radius: 1000,
      strokeWidth: 1,
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: CustomAppBar(),
      body: Stack(
        children: [
          // Init Google Map
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              tilt: 2.0,
              target: LatLng(29.990940, 31.149248),
              zoom: 14,
              bearing: 3.5,
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                myMarkers.add(
                  Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(29.990940, 31.149248),
                    icon: BitmapDescriptor.defaultMarkerWithHue(2),
                    onTap: () {
                      print('Marker tabed');
                    },
                    infoWindow: InfoWindow(
                      title: 'Titlesss',
                    ),
                  ),
                );
              });
            },
            // polylines: myPolyline.toSet(),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.28,
            minChildSize: 0.28,
            maxChildSize: 0.55,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(0xff1B1B1B),
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(22),
                  //   topRight: Radius.circular(22),
                  // ),
                ),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (scroll) {
                    scroll.disallowGlow();
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 17,
                        ),
                        Container(
                          width: 45,
                          height: 3,
                          color: Color(0xff161616),
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.91,
                          height: 60,
                          color: Color(0xff282828),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                // flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  // color: Colors.green,
                                  child: Text(
                                    'Where to go?',
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // Spacer(),
                              VerticalDivider(
                                color: Colors.white12,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Flexible(
                                // flex: 1,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FlatButton(
                                        color: Color(0xff1B1B1B),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Now',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Favorite & Recent rides...
                        Container(
                          width: MediaQuery.of(context).size.width * 0.91,
                          height: 80,
                          // color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 39,
                                  height: 39,
                                  color: Color(0xff272727),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Maadi Metro Station',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'المعادي، القاهرة',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          indent: 67,
                          color: Colors.white10,
                          thickness: 1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.91,
                          height: 80,
                          // color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 39,
                                  height: 39,
                                  color: Color(0xff272727),
                                  child: Icon(
                                    Icons.add_location_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Computer Mall',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'المعادي، القاهرة - Maadi, Cairo',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Menu

          Positioned(
              top: 37,
              left: 10,
              child: ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  width: 47,
                  height: 47,
                  color: Color(0xff1B1B1B),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _scaffoldKey.currentState.openDrawer();
                      });
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animationOffset;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    _animationOffset =
        Tween<Offset>(begin: Offset(-2.0, 0.0), end: Offset(-2.0, 0.0)).animate(
      CurvedAnimation(
        curve: Curves.easeInExpo,
        parent: _animationController,
      ),
    );
  }

  _startAnimation() {
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.forward();
    } else if (_animationController.status == AnimationStatus.dismissed) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // elevation: 0,
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(
              height: 55,
            ),
            // Avatar - pic
            Container(
              margin: EdgeInsets.only(left: 20),
              // color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      color: Color(0xfff7f7f0),
                      width: 65,
                      height: 65,
                      child: Icon(Icons.person, size: 55),
                    ),
                  ),

                  // Username & User servay
                  Container(
                    margin: EdgeInsets.only(left: 13),
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Muhammad Kamel',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '5.0',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 16),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.star,
                              color: Colors.white54,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.white38,
              height: 5,
              indent: 20,
            ),
            // Messages
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 53,
              // width: MediaQuery.of(context).size.width * 0.60,
              // color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Messages',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  // SizedBox(width: 1),
                ],
              ),
            ),
            Divider(
              color: Colors.white38,
              height: 5,
              indent: 20,
            ),

            // Do more with your account
            Container(
              height: 57,
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Do more with your account',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),

            // Make maney driving
            Container(
              padding: EdgeInsets.only(left: 20),
              height: 57,
              alignment: Alignment.centerLeft,
              child: Text(
                'Make maney driving',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.centerLeft,
                color: Color(0xff1B1B1B),
                padding: EdgeInsets.only(left: 20),
                // height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Trips',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Help',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Bus Routes',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Wallet',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      // title: Container(
      //   padding: EdgeInsets.symmetric(vertical: 0),
      //   child: Center(
      //     // alignment: Alignment.bottomCenter,
      //     child: Text(
      //       'Google Maps - Flutter',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(color: Colors.black45, fontSize: 18),
      //     ),
      //   ),
      // ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(60);
  }
}
