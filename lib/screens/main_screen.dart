import 'package:flutter/material.dart';
import 'package:yehyefirebasee/screens/bnb/prorducts_view.dart';
import 'package:yehyefirebasee/screens/bnb/task_view.dart';
import '../Helpers/navigator_helper.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with NavigatorHelper {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const TaskView(),
        const ProductView(),
      const Center()
      ][selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (_)=>setState(()=>selectedIndex = _ ),
        currentIndex: selectedIndex,
        items: [
        const  BottomNavigationBarItem(
              icon: Icon(Icons.task_alt),
              label: 'task'),
        const  BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'product'),
       const   BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'more'),
        ],
      ),
    );
  }
}

