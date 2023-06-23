import 'package:flutter/material.dart';

class DynamicNavBarButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final bool showForeGround;
  final ValueChanged<int> onTap;
  final IconData icon;
  final String title;
  final int currentIndex;
  final Color? selectedIconColor;
  final double? selectedIconSize;   
  final double? selectedTextSize;  
  final Color? selectedTextColor;
  final Color? unselectedIconColor;
  final double? unselectedIconSize;   
  final double? unselectedTextSize;  
  final Color? unselectedTextColor;

  const DynamicNavBarButton({super.key, 
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.showForeGround,
    required this.icon,
    required this.title,
    required this.currentIndex,
    required this.selectedIconColor,
    required this.selectedIconSize,   
    required this.selectedTextSize,  
    required this.selectedTextColor,
    required this.unselectedIconColor,
    required this.unselectedIconSize,   
    required this.unselectedTextSize,  
    required this.unselectedTextColor,
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
        child: isSelected
        ?SelectedButtonWidget(
          showForeGround: showForeGround, 
          index: index, 
          length: length, 
          title: title,
          icon: icon,
          selectedIconColor: selectedIconColor,
          selectedIconSize:selectedIconSize,
          selectedTextSize:selectedTextSize,
          selectedTextColor:selectedTextColor,
        )
        :UnSelectedButtonWidget(
          showForeGround: showForeGround, 
          index: index, 
          length: length, 
          title: title,
          icon: icon,
          unselectedIconColor: unselectedIconColor,
          unselectedIconSize: unselectedIconSize,
          unselectedTextSize: unselectedTextSize,
          unselectedTextColor: unselectedTextColor,
        ),
      ),
    );
  }
}

class StaticNavBarButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final bool showForeGround;
  final bool showCircleStaticMidItem;
  final ValueChanged<int> onTap;
  final IconData icon;
  final String title;
  final int currentIndex;
  final Color? selectedIconColor;
  final double? selectedIconSize;   
  final double? selectedTextSize;  
  final Color? selectedTextColor;
  final Color? unselectedIconColor;
  final double? unselectedIconSize;   
  final double? unselectedTextSize;  
  final Color? unselectedTextColor;
  final Color? midItemCircleColor;
  final Color? midItemCircleBorderColor;
  final bool showMidCircleStatic;
  final double midCircleRadiusStatic;
  final double midCircleBorderRadiusStatic;

  const StaticNavBarButton({
    super.key, 
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.showForeGround,
    required this.showCircleStaticMidItem,
    required this.icon,
    required this.title,
    required this.currentIndex,
    required this.selectedIconColor,
    required this.selectedIconSize,   
    required this.selectedTextSize,  
    required this.selectedTextColor,
    required this.unselectedIconColor,
    required this.unselectedIconSize,   
    required this.unselectedTextSize,  
    required this.unselectedTextColor,
    required this.midItemCircleColor,
    required this.midItemCircleBorderColor,
    required this.showMidCircleStatic,
    required this.midCircleRadiusStatic,
    required this.midCircleBorderRadiusStatic,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    final midItem = length ~/ 2;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async{
          onTap(index);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            index == midItem && showMidCircleStatic
            ?CircleAvatar(
              radius: midCircleRadiusStatic+midCircleBorderRadiusStatic,
              backgroundColor: midItemCircleBorderColor,
              child: CircleAvatar(
                backgroundColor: midItemCircleColor,
                radius: midCircleRadiusStatic,
              ),
            )
            :const SizedBox(),
            isSelected
            ?SelectedButtonWidget(
              showForeGround: showForeGround, 
              index: index, 
              length: length, 
              title: title,
              icon: icon,
              selectedIconColor: selectedIconColor,
              selectedIconSize:selectedIconSize, 
              selectedTextSize:selectedTextSize,  
              selectedTextColor:selectedTextColor,
            )
            :UnSelectedButtonWidget(
              showForeGround: showForeGround, 
              index: index, 
              length: length, 
              title: title,
              icon: icon,
              unselectedIconColor: unselectedIconColor,
              unselectedIconSize:unselectedIconSize, 
              unselectedTextSize:unselectedTextSize,  
              unselectedTextColor:unselectedTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedButtonWidget extends StatelessWidget {
  const SelectedButtonWidget({
    super.key,
    required this.showForeGround,
    required this.index,
    required this.length,
    required this.title,
    required this.icon,
    required this.selectedIconColor,
    required this.selectedIconSize,
    required this.selectedTextSize,
    required this.selectedTextColor,
  });

  final IconData icon;
  final bool showForeGround;
  final int index;
  final int length;
  final String title;
  final Color? selectedIconColor;
  final double? selectedIconSize;   
  final double? selectedTextSize;  
  final Color? selectedTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selectedIconColor??Colors.red, // Change the color to your desired color
            size: selectedIconSize??30, // Change the size to your desired size
          ),
          title=="" ? const SizedBox() : Text(title,style: TextStyle(color: selectedTextColor,fontSize: selectedTextSize))
        ],
      )
    );
  }
}

class UnSelectedButtonWidget extends StatelessWidget {
  const UnSelectedButtonWidget({
    super.key,
    required this.showForeGround,
    required this.index,
    required this.length,
    required this.title,
    required this.icon,
    required this.unselectedIconColor,
    required this.unselectedIconSize,
    required this.unselectedTextSize,
    required this.unselectedTextColor,
  });

  final IconData icon;
  final bool showForeGround;
  final int index;
  final int length;
  final String title;
  final Color? unselectedIconColor;
  final double? unselectedIconSize;   
  final double? unselectedTextSize;  
  final Color? unselectedTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: unselectedIconColor??Colors.red, // Change the color to your desired color
            size: unselectedIconSize??30, // Change the size to your desired size
          ),
          title=="" ? const SizedBox() : Text(title,style: TextStyle(color: unselectedTextColor,fontSize: unselectedTextSize??18))
        ],
      )
    );
  }
}