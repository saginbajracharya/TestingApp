import 'package:flutter/material.dart';
import '../utils/styles.dart';

//page Explaning a Stateful Widget LifeCycle

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State(); // 1 createState()  
}

class _Page1State extends State<Page1> {

  @override
  void initState() { // 2 initState()
    super.initState();
  }

  // 3 didChangeDependencies()
  // This method is called immediately after initState and when dependency of the State object changes via InheritedWidget.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) { // 4 build()
    setState(() { // 6 setState()
    });
    return const Text("PAGE 1",style: TextStyle(color: black,fontSize: 40.0));
  }

  // 5 didUpdateWidget()
  // This method is called whenever the widget configuration changes. A typical case is when a parent passes some variable to the children() widget via the constructor.
  @override
  void didUpdateWidget(covariant Page1 oldWidget) { 
    super.didUpdateWidget(oldWidget);
  }

  // 7 deactivate()
  // It is used when the state is removed from the tree but before the current frame change can be re-inserted into another part of the tree
  @override
  void deactivate() { 
    super.deactivate();
  }

  // 8 dispose()
  // We use this method when we remove permanently like should release resource created by an object like stop animation
  @override
  void dispose() { 
    super.dispose();
  }
}