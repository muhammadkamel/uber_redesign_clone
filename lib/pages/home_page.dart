import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  double _height, min = 0.1, initial = 0.3, max = 0.7;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          child: AnimatedIcon(
              icon: AnimatedIcons.menu_close, progress: _controller),
          elevation: 5,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          onPressed: () {
            _controller.isDismissed
                ? _controller.forward()
                : _controller.reverse();
          },
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            FlutterLogo(size: 500),
            SizedBox.expand(
              child: SlideTransition(
                position: _tween.animate(_controller),
                child: DraggableScrollableSheet(
                  minChildSize:
                      min, // 0.1 times of available height, sheet can't go below this on dragging
                  maxChildSize:
                      max, // 0.7 times of available height, sheet can't go above this on dragging
                  initialChildSize:
                      initial, // 0.1 times of available height, sheet start at this size when opened for first time
                  builder: (BuildContext context, ScrollController controller) {
                    if (controller.hasClients) {
                      var dimension = controller.position.viewportDimension;
                      _height ??= dimension / initial;
                      if (dimension >= _height * max * 0.9) {
                        print("at top");
                        print(dimension);
                      } else if (dimension <= _height * min * 1.1) {
                        print("at bottom");
                        print(dimension);
                      }
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      child: Container(
                        height: 500.0,
                        color: Colors.blue[800],
                        child: ListView.builder(
                          controller: controller,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(title: Text('Item $index'));
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
