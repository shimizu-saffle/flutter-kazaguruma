// https://zenn.dev/pressedkonbu/books/flutter-reverse-lookup-dictionary/viewer/017-flutter-kazaguruma

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter風車',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: FlutterKazaguruma(
          size: 200,
          duration: Duration(milliseconds: 10000000),
        ),
      ),
    );
  }
}

class FlutterKazaguruma extends StatelessWidget {
  const FlutterKazaguruma({
    Key? key,
    required this.size,
    required this.duration,
  }) : super(key: key);

  final double size;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterWing(
          size: size,
          duration: duration,
        ),
        // FlutterWing(
        //   size: size,
        //   duration: duration,
        //   angle: (pi / 2) * 1, // 90度回転
        // ),
        FlutterWing(
          size: size,
          duration: duration,
          angle: 15, // 180度回転
        ),
        // FlutterWing(
        //   size: size,
        //   duration: duration,
        //   angle: (pi / 2) * 3, // 270度回転
        // ),
      ],
    );
  }
}

/// 風車の羽根の部分
class FlutterWing extends StatefulWidget {
  const FlutterWing({
    Key? key,
    required this.size,
    required this.duration,
    this.angle = 0,
  }) : super(key: key);
  final double size;
  final double angle;
  final Duration duration;

  @override
  State<FlutterWing> createState() => _FlutterWingState();
}

class _FlutterWingState extends State<FlutterWing>
    with SingleTickerProviderStateMixin {
  late final controller =
      AnimationController(vsync: this, duration: widget.duration)..repeat();

  @override
  Widget build(BuildContext context) {
    // ウィジェットの位置を回転させるウィジェット（アニメーションでは無い）
    return Transform.rotate(
      angle: widget.angle,
      child: Container(
        // 回転軸をずらすためにロゴを左下においやっています
        width: widget.size * 2,
        height: widget.size * 2,
        alignment: Alignment.bottomLeft,
        // ウィジェットに回転アニメーションをつけるためのウィジェット
        child: RotationTransition(
          turns: controller,
          // ロゴそのものの回転軸は右上にしています。
          alignment: Alignment.topRight,
          child: FlutterLogo(
            size: widget.size,
          ),
        ),
      ),
    );
  }
}
