import 'package:flutter/material.dart';

class MarioPixelArt extends StatelessWidget {
  const MarioPixelArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Puntos de Ayuda')),
      body: Center(
        child: CustomPaint(
          size: const Size(20, 20), // Tamaño del sprite de Mario
          painter: MarioPixelPainter(),
        ),
      ),
    );
  }
}

class MarioPixelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    final double pixelSize = size.width / 16; // Tamaño de cada "píxel"

    // Definir los colores
    const Color red = Colors.red;
    const Color blue = Colors.blue;
    const Color skin = Colors.amber;
    const Color black = Colors.black;
    const Color white = Colors.white;
    const Color green = Colors.green;
    const Color yellow = Colors.yellow;
    const Color orange = Colors.orange;
    const Color purple = Colors.purple;
    const Color brown = Colors.brown;
    const Color pink = Colors.pink;
    const Color grey = Colors.grey;
    const Color cyan = Colors.cyan;
    const Color lime = Colors.lime;
    const Color indigo = Colors.indigo;
    const Color teal = Colors.teal;

    // Mapa de colores
    final Map<int, Color> colorMap = {
      0: Colors.transparent, // Fondo transparente
      1: red,
      2: blue,
      3: skin,
      4: black,
      5: white,
      6: green,
      7: yellow,
      8: orange,
      9: purple,
      10: brown,
      11: pink,
      12: grey,
      13: cyan,
      14: lime,
      15: indigo,
      16: teal,
    };

    final List<List<int>> pixelData = [
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 12, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 12, 7, 7, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 12, 7, 5, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 12, 7, 5, 5, 7, 7, 12, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 12, 7, 5, 5, 7, 7, 12, 0, 0, 0, 0, 0, 0, 0],
      [
        12,
        12,
        12,
        12,
        12,
        12,
        12,
        7,
        5,
        5,
        7,
        7,
        12,
        12,
        12,
        12,
        12,
        12,
        12,
        0
      ],
      [12, 7, 7, 7, 7, 7, 7, 5, 5, 7, 7, 7, 7, 7, 7, 7, 7, 7, 12, 0],
      [0, 12, 7, 7, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7, 7, 7, 12, 0, 0],
      [0, 0, 12, 7, 7, 5, 5, 5, 7, 7, 7, 7, 7, 7, 7, 7, 12, 0, 0, 0],
      [0, 0, 0, 12, 7, 7, 5, 5, 7, 7, 7, 7, 7, 7, 7, 12, 0, 0, 0, 0],
      [0, 0, 0, 0, 12, 7, 7, 5, 7, 7, 7, 7, 7, 7, 12, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 12, 7, 7, 5, 7, 7, 7, 7, 7, 7, 12, 0, 0, 0, 0, 0],
      [0, 0, 0, 12, 7, 7, 7, 7, 12, 12, 12, 7, 7, 7, 7, 12, 0, 0, 0, 0],
      [0, 0, 0, 12, 7, 7, 7, 12, 0, 0, 00, 12, 7, 7, 7, 12, 0, 0, 0, 0],
      [0, 0, 12, 7, 7, 7, 12, 0, 0, 0, 0, 0, 12, 7, 7, 7, 12, 0, 0, 0],
      [0, 0, 12, 7, 7, 12, 0, 0, 0, 0, 0, 0, 0, 12, 12, 7, 12, 0, 0, 0],
      [0, 0, 12, 12, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 12, 12, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    ];

    for (int y = 0; y < pixelData.length; y++) {
      for (int x = 0; x < pixelData[y].length; x++) {
        paint.color = colorMap[pixelData[y][x]] ?? Colors.transparent;
        canvas.drawRect(
          Rect.fromLTWH(x * pixelSize, y * pixelSize, pixelSize, pixelSize),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
