import 'package:flutter/material.dart';

class DynamicNavBarButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;
  final RichText title;

  const DynamicNavBarButton({super.key, 
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: 75.0,
          child: Transform.translate(
            offset: Offset(
              0, 
              difference < 1.0 / length ? verticalAlignment * 40 : 0
            ),
            child: Opacity(
              opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child,
                  title.text.toPlainText() == "" ? const SizedBox() : title
                ],
              )
            ),
          )
        ),
      ),
    );
  }
}

class StaticNavBarButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;
  final RichText title;

  const StaticNavBarButton({super.key, 
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: 75.0,
          child: Opacity(
            opacity: difference < 1.0 / length * 0.99 ? 1 : 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                child,
                title.text.toPlainText() == "" ? const SizedBox() : title
              ],
            )
          )
        ),
      ),
    );
  }
}