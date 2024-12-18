import 'package:flutter/material.dart';

class CustomAnimatedIcon extends StatelessWidget {
  const CustomAnimatedIcon({
    super.key,
    required this.fromIcon,
    required this.toIcon,
    required this.animation,
    required this.color,
    this.onTap,
  });

  final IconData fromIcon;
  final IconData toIcon;
  final Animation<double> animation;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeTransition(
              opacity: Tween<double>(
                begin: 1.0,
                end: 0.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
                ),
              ),
              child: RotationTransition(
                turns: Tween<double>(
                  begin: 0.0,
                  end: 0.125,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
                  ),
                ),
                child: Icon(fromIcon, color: color),
              ),
            ),
            FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
                ),
              ),
              child: RotationTransition(
                turns: Tween<double>(
                  begin: -0.125,
                  end: 0.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
                  ),
                ),
                child: Icon(toIcon, color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
