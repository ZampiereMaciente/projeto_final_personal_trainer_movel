import 'package:flutter/material.dart';

class RainbowText extends StatefulWidget {
  final String text;
  final double fontSize;

  const RainbowText({
    super.key,
    required this.text,
    this.fontSize = 28,
  });

  @override
  State<RainbowText> createState() => _RainbowTextState();
}

class _RainbowTextState extends State<RainbowText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // Declara um objeto Animation que representa o valor animado
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: const Duration(seconds: 4), vsync: this)
      ..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * 3.1415).animate(_controller);
  }

  // liberar o AnimationController para evitar vazamentos de memória.
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // especie de gradiante
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: const [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              // realiza a rotacao usando _animation.value no valor de 0 a 2 * pi
              transform: GradientRotation(_animation.value),
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: const [
                Shadow(
                  color: Colors.black,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
