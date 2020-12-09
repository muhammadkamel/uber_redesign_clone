import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/pages/custom_search.dart';
import 'package:google_maps/pages/search_ride.dart';
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

  Route _createRouteAnimation(Widget pageToGo) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageToGo,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        // appBar: CustomAppBar(),
        body: Stack(
          children: [
            // Init Google Map
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                tilt: 2.0,
                target: LatLng(29.9602, 31.2569),
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
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    // width: 300,
                                    height: 70,
                                    // color: Colors.redAccent,
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal: 10, vertical: 5),
                                    // color: Colors.green,

                                    child: OutlineButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          _createRouteAnimation(SearchRide()),
                                        );
                                      },
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 20),
                                      borderSide: BorderSide.none,
                                      child: Text(
                                        'Where to go?',
                                        style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Spacer(),
                                VerticalDivider(
                                  color: Colors.white12,
                                  indent: 10,
                                  endIndent: 10,
                                  width: 0,
                                ),
                                Flexible(
                                  flex: 2,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                top: 10,
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
      ),
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
              alignment: Alignment.bottomLeft,
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
              // flex: 2,
              child: Container(
                alignment: Alignment.topLeft,
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
      backgroundColor: Colors.black,
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

// Custom Rides
class CustomRide extends StatefulWidget {
  @override
  _CustomRideState createState() => _CustomRideState();
}

class _CustomRideState extends State<CustomRide> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1B1B1B),

        // backgroundColor: Colors.transparent,
        body: Container(
          // alignment: Alignment.center,
          // color: Colors.blueGrey,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width * 0.69,
                  // color: Colors.greenAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.topCenter,
                          // width: 33,
                          // height: 33,
                          margin: EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.arrow_back,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 50,
                      // ),
                      Container(
                        alignment: Alignment.center,
                        width: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Container(
                                color: Color(0xfff7f7f0),
                                width: 27,
                                height: 27,
                                child: Icon(
                                  Icons.person,
                                  size: 22,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'For Me',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 28,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              // Current location

              // Ride
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 1,
                        height: 39,
                        color: Colors.white,
                      ),
                      Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  Container(
                    // width: MediaQuery.of(context).size.width * 0.80,
                    // color: Colors.redAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width * 0.73,
                            height: 35,
                            color: Color(0xff1F1F1F),
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: Text(
                              'Tahrer Square',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 7),
                        // Where to go - address
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width * 0.73,
                                height: 35,
                                color: Color(0xff282828),
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  decoration: InputDecoration(
                                    hintText: 'Where to?',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                    contentPadding: EdgeInsets.all(5.0),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
