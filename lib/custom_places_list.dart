import 'package:flutter/material.dart';

class CustomPlaces extends StatelessWidget {
  const CustomPlaces(
      {Key key,
      @required this.width,
      @required this.text,
      @required this.icon,
      this.subTitle})
      : super(key: key);

  final double width;
  final String text;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        // width: width,
        // height: 59,
        padding: EdgeInsets.symmetric(vertical: 3),
        color: Color(0xff1B1B1B),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      // color: Colors.orangeAccent,
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff5A5A5A),
                            ),
                            child: Icon(
                              icon,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 25),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              if (subTitle != null)
                                Text(
                                  subTitle ?? '',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 14,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
