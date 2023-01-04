import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gif_flutter/gif_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late GifController controller1, controller2, controller3, controller4;

  @override
  void initState() {
    controller1 = GifController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    controller2 = GifController(vsync: this);
    controller4 = GifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller1.repeat(
        min: 0,
        max: 54,
        period: const Duration(milliseconds: 2000),
      );
    });
    controller1.addListener(() {
      log(controller1.value.toString());
      if (controller1.value >= 53) {
        controller1.stop();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller2.repeat(
        min: 0,
        max: 13,
        period: const Duration(milliseconds: 2000),
      );
      controller4.repeat(
          min: 0, max: 13, period: const Duration(milliseconds: 2000));
    });
    controller3 = GifController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GifImage(
                  controller: controller1,
                  image: const AssetImage("images/animate.gif"),
                ),
                GifImage(
                  controller: controller2,
                  image: const NetworkImage(
                    "http://img.mp.itc.cn/upload/20161107/5cad975eee9e4b45ae9d3c1238ccf91e.jpg",
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                  child: const Text("start"),
                  onPressed: () {
                    controller3.repeat(
                        min: 0,
                        max: 25,
                        period: const Duration(milliseconds: 500));
                  },
                ),
                ElevatedButton(
                  child: const Text("stop"),
                  onPressed: () {
                    controller3.stop();
                  },
                ),
                ElevatedButton(
                  child: const Text("animation to"),
                  onPressed: () {
                    controller3.animateTo(52,
                        duration: const Duration(milliseconds: 1000));
                  },
                )
              ],
            ),
            Slider(
              onChanged: (v) {
                controller3.value = v;
                setState(() {});
              },
              max: 53,
              min: 0,
              value: controller3.value,
            ),
            GifImage(
              controller: controller3,
              image: const AssetImage("images/animate.gif"),
            ),
          ],
        ),
      ),
    );
  }
}
