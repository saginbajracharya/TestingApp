import 'package:flutter/material.dart';
import '../utils/styles.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Text("PAGE 1",style: TextStyle(color: white))
        )
      ],
    );
  }
}