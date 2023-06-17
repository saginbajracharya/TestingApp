import 'package:flutter/material.dart';
import '../utils/styles.dart';

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Text("PAGE 5",style: TextStyle(color: white))
        )
      ],
    );
  }
}