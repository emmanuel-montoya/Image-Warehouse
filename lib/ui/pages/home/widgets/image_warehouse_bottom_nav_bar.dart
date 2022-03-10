import 'package:flutter/material.dart';

class ImageWarehouseBottomNavBar extends StatefulWidget {

  final List<ImageWarehouseBottomNavBarItem> items;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  ImageWarehouseBottomNavBar({Key? key,
    required this.items,
    this.height = 60.0,
    this.iconSize = 20.0,
    this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.notchedShape,
    required this.onTabSelected,
  }) : super(key: key) {
    assert(items.length == 2);
  }

  @override
  State<StatefulWidget> createState() => ImageWarehouseBottomNavBarState();
}

class ImageWarehouseBottomNavBarState extends State<ImageWarehouseBottomNavBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }


  Widget _buildTabItem({
    ImageWarehouseBottomNavBarItem? item,
    int index = 0,
    ValueChanged<int>? onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed!(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item!.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageWarehouseBottomNavBarItem {
  ImageWarehouseBottomNavBarItem({required this.iconData, required this.text});
  IconData iconData;
  String text;
}

