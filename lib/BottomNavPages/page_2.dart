import 'package:flutter/material.dart';
import '../utils/styles.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Text("PAGE 2",style: TextStyle(color: white))
          )
        )
      ],
    );
  }
}