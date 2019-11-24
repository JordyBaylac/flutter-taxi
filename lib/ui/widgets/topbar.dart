import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:zitotaxi/services/theme_service.dart';
import 'package:zitotaxi/state/navigation_notifier.dart';
import 'package:zitotaxi/ui/pages/routes.dart';

getTopBar() => PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: _TopBar(),
    );

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationNotifier>(
      builder: (context, state, child) {
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
                  isSelected: state.selectedPage == Page.home,
                  onSelect: () {
                    if (state.selectedPage != Page.home) {
                      Routes.sailor.navigate(
                        "/home",
                        transitions: [SailorTransition.fade_in],
                      );
                    }
                    state.selectPage(Page.home);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: _MenuItem(
                  title: "About us",
                  isSelected: state.selectedPage == Page.about,
                  onSelect: () {
                    if (state.selectedPage != Page.about) {
                      Routes.sailor.navigate(
                        "/about",
                        transitions: [SailorTransition.fade_in],
                      );
                    }
                    state.selectPage(Page.about);
                  },
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        );
      },
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
          Row(
            children: <Widget>[
              Spacer(),
              Expanded(flex: 2, child: _selector(context)),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  _selector(BuildContext context) {
    final duration = Duration(milliseconds: 400);
    final curve = Curves.easeIn;

    return AnimatedPadding(
      duration: duration,
      curve: curve,
      padding: isSelected ? EdgeInsets.symmetric(horizontal: 5) : EdgeInsets.symmetric(horizontal: 40),
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
