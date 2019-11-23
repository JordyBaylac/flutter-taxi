import 'package:flutter/material.dart';
import 'package:zitotaxi/services/theme_service.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  int selectedMenuItem = 0;

  _selectMenuItem(int index) => setState(() {
        selectedMenuItem = index;
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Container(),
        ),
        Expanded(
          flex: 1,
          child: _MenuItem(
            title: "Home",
            isSelected: selectedMenuItem == 0,
            onSelect: () => _selectMenuItem(0),
          ),
        ),
        Expanded(
          flex: 1,
          child: _MenuItem(
            title: "Book",
            isSelected: selectedMenuItem == 1,
            onSelect: () => _selectMenuItem(1),
          ),
        ),
        Expanded(
          flex: 1,
          child: _MenuItem(
            title: "Gallery",
            isSelected: selectedMenuItem == 2,
            onSelect: () => _selectMenuItem(2),
          ),
        ),
        Expanded(
          flex: 1,
          child: _MenuItem(
            title: "About",
            isSelected: selectedMenuItem == 3,
            onSelect: () => _selectMenuItem(3),
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  const _MenuItem({Key key, this.title, this.isSelected, this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(title),
          isSelected
              ? Container(
                  height: 10,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorSchemeOf(context).secondaryVariant,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
