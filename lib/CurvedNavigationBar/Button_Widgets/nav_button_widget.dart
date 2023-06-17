import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class DynamicNavBarButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;
  final String title;
  final int currentIndex;

  const DynamicNavBarButton({super.key, 
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
    required this.title,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: 75.0,
          child: isSelected
          ?const SizedBox() 
          :Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              child,
              isSelected
              ?const Text('',style: TextStyle(color: blue))
              :title=="" ? const SizedBox() : Text(title,style: const TextStyle(color: blue))
            ],
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
  final String title;
  final int currentIndex;

  const StaticNavBarButton({super.key, 
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
    required this.title,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    // final isSelected = index == currentIndex;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: 75.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              child,
              index == length ~/ 2
              ?const SizedBox()
              :title=="" ? const SizedBox() : Text(title,style: const TextStyle(color: blue))
            ],
          )
        ),
      ),
    );
  }
}