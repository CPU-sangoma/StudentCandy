import 'dart:ui';
import 'package:flutter/material.dart';



class BackGroundEffect extends StatelessWidget {
  final Widget CurrentScreen;
  final double backgroundHeight;
  final double containerHeight;

  BackGroundEffect({
    @required this.CurrentScreen,
    @required this.containerHeight,
    @required this.backgroundHeight,

  });

  var appbar = AppBar();

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Stack(
                  children: <Widget>[
                  Container(
                        height: backgroundHeight,
                        width: mq.size.width * 1,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: mq.size.width * 0.2,
                                    height: (mq.size.height - mq.padding.top) * 0.2,
                                    decoration: BoxDecoration(
                                        color: Colors.cyanAccent,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.pink,
                                              offset: Offset(20,20),
                                              blurRadius: 40,
                                              spreadRadius: 20.0
                                          ),
                                        ]
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Container(
                                      height: (mq.size.height - mq.padding.top) * 0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.amber,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.green,
                                              offset: Offset(20,12),
                                              blurRadius: 20.0,
                                              spreadRadius: 20.2,

                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: mq.size.width * 0.3,
                                    height: (mq.size.height - mq.padding.top) * 0.2,
                                    decoration: BoxDecoration(
                                        color: Colors.red[400],
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.indigoAccent,
                                              offset: Offset(20,20),
                                              blurRadius: 40,
                                              spreadRadius: 20.0
                                          ),
                                        ]
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Container(
                                      height: (mq.size.height - mq.padding.top) * 0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.purple,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.amber,
                                              offset: Offset(20,20),
                                              blurRadius: 20.0,
                                              spreadRadius: 20.2,

                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: mq.size.width * 0.3,
                                    height: (mq.size.height - mq.padding.top) * 0.2,
                                    decoration: BoxDecoration(
                                        color: Colors.orangeAccent[400],
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue,
                                            offset: Offset(20,20),
                                            blurRadius: 40,
                                            spreadRadius: 20.0,
                                          ),
                                        ]
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Container(
                                      height: (mq.size.height - mq.padding.top) * 0.2,
                                      decoration: BoxDecoration(
                                          color: Colors.indigoAccent,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.deepOrange,
                                              offset: Offset(20,20),
                                              blurRadius: 20.0,
                                              spreadRadius: 20.2,

                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30.0,sigmaY: 30.0),
                      child: SingleChildScrollView(
                        child: Container(
                            height: containerHeight,
                            width: mq.size.width * 1,
                            color: Colors.white.withOpacity(0.4),
                            child: CurrentScreen,
                        ),
                      ),
                    )
                  ],
                );

  }
}