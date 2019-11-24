import 'package:flutter/material.dart';
import 'package:zitotaxi/services/theme_service.dart';
import 'package:zitotaxi/ui/pages/routes.dart';

getTopBar() => PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: _TopBar(
        key: ValueKey("topbar"),
      ),
    );

class _TopBar extends StatefulWidget {
  _TopBar({Key key}) : super(key: key);
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<_TopBar> {
  int selectedMenuItem = 0;

  _selectMenuItem(int index) => setState(() {
        selectedMenuItem = index;
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppBarTheme.of(context).color,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 1,
            child: _MenuItem(
              title: "Home",
              isSelected: selectedMenuItem == 0,
              onSelect: () async {
                await Routes.sailor.navigate(
                  "/home",
                );
                _selectMenuItem(0);
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: _MenuItem(
              title: "About us",
              isSelected: selectedMenuItem == 1,
              onSelect: () async {
                await Routes.sailor.navigate(
                  "/about",
                );
                _selectMenuItem(1);
              },
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onSelect;

  const _MenuItem({Key key, this.title, this.isSelected, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: <Widget>[
          Spacer(flex: 2),
          Text(title),
          Spacer(flex: 2),
          _selector(context),
        ],
      ),
    );
  }

  _selector(BuildContext context) {
    final duration = Duration(milliseconds: 300);
    final curve = Curves.easeIn;

    return AnimatedPadding(
      duration: duration,
      curve: curve,
      padding: isSelected ? EdgeInsets.symmetric(horizontal: 10) : EdgeInsets.symmetric(horizontal: 40),
      child: AnimatedContainer(
        duration: duration,
        curve: curve,
        height: 7,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? colorSchemeOf(context).onSecondary.withOpacity(.8) : Colors.transparent,
        ),
      ),
    );
  }
}
