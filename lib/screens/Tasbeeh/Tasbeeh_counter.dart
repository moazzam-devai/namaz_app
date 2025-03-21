import 'package:al_khair/controllers/TasbeehController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasbeehCounter extends StatefulWidget {
  const TasbeehCounter({super.key});

  @override
  _TasbeehCounterState createState() => _TasbeehCounterState();
}

class _TasbeehCounterState extends State<TasbeehCounter> {
  final TasbeehController _controller = Get.put(TasbeehController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222933),
      appBar: AppBar(
        title: Text(
          'Tasbeeh Counter',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF222933),
        elevation: 0,
      ),
      body: Center(
        // Centering the body content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFFFFDB6B),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: Colors.white.withOpacity(.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Center(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Obx(
                  () => Text(
                    '${_controller.counter.value}',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
            ),
            Transform.translate(
              offset: Offset(0, -40),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFFFFDB6B),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _controller.increment,
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(80, 80),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF222933),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: _controller.reset,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
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
