import 'package:flutter/material.dart';
import 'package:google_maps/custom_places_list.dart';

class CustomSearch extends StatefulWidget {
  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch>
    with TickerProviderStateMixin {
  // double _width = 390;
  double _initSize = 0.3;
  double _maxSize = 1.0;
  double _minSize = 0.2;

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )
      ..repeat()
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(
      begin: 2.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.easeInCubic,
        parent: _controller,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xff1b1b1b),
        // backgroundColor: Colors.greenAccent,
        body: Column(
          children: [
            // App Header bar
            Container(
              // alignment: Alignment.center,
              color: Color(0xff1B1B1B),
              // height: 140,
              padding: EdgeInsets.symmetric(vertical: 10),
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
                  Container(
                    // color: Colors.red,
                    // margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Ride line
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                ),
                              ),
                              SizedBox(height: 2),
                              Container(
                                alignment: Alignment.center,
                                width: 1,
                                height: 30,
                                color: Colors.white70,
                              ),
                              SizedBox(height: 2),
                              Container(
                                width: 8,
                                height: 9,
                                decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          // width: MediaQuery.of(context).size.width * 0.80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width:
                                      MediaQuery.of(context).size.width * 0.73,
                                  height: 35,
                                  color: Color(0xff1F1F1F),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.73,
                                      height: 35,
                                      color: Color(0xff282828),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3),
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
                                  SizedBox(width: 15),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    // color: Colors.teal,
                                    alignment: Alignment.bottomCenter,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
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
            // Draggable list - places
            Flexible(
              child: DraggableScrollableSheet(
                initialChildSize: _initSize,
                maxChildSize: _maxSize,
                minChildSize: _minSize,
                builder: (context, scrollController) {
                  if (scrollController.hasClients) {
                    var myVal = scrollController.position.viewportDimension;
                    if (myVal < 300) {
                      // _width = MediaQuery.of(context).size.width * 0.90;
                    } else if (myVal > 300) {
                      // _width = MediaQuery.of(context).size.width * 0.95;
                    } else if (myVal > 350) {
                      // _width = MediaQuery.of(context).size.width * 0.99;
                    } else if (myVal > 360) {
                      // _width = MediaQuery.of(context).size.width;
                    }
                  }
                  return Container(
                    // padding: EdgeInsets.only(top: 5),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        CustomPlaces(
                          width: MediaQuery.of(context).size.width,
                          icon: Icons.star,
                          text: 'Saved Places',
                        ),
                        CustomPlaces(
                          width: MediaQuery.of(context).size.width,
                          icon: Icons.access_time,
                          text: 'Metro',
                          subTitle: 'محطة مترو المعادي',
                        ),
                        CustomPlaces(
                          width: MediaQuery.of(context).size.width,
                          icon: Icons.access_time,
                          text: 'Work address',
                          subTitle: 'Zahra Maadi',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
