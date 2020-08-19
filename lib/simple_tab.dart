import 'package:first_flutter_app/blocs/cubit/plantscubit_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleTab extends StatefulWidget {
  final List<String> tabTitles;
  final int currentTabIndex;
  final Function onTabChanged;

  SimpleTab(this.tabTitles, this.currentTabIndex, this.onTabChanged);

  @override
  State<StatefulWidget> createState() {
    return _SimpleTabState();
  }
}

class _SimpleTabState extends State<SimpleTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.tabTitles
                .asMap()
                .entries
                .map((e) =>
                    SingleTab(e, widget.onTabChanged, widget.currentTabIndex))
                .toList()));
  }
}

class SingleTab extends StatelessWidget {
  final MapEntry<int, String> item;
  final Function onTabChanged;
  final int currentSelection;

  SingleTab(this.item, this.onTabChanged, this.currentSelection) {
    print("Single tab ${this.currentSelection}");
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentSelection = item.key == this.currentSelection;
    return GestureDetector(
        onTap: () {
          this.onTabChanged(this.item.key);
        },
        child: Text(
          this.item.value,
          style: TextStyle(
              fontWeight:
                  isCurrentSelection ? FontWeight.bold : FontWeight.normal,
              fontSize: isCurrentSelection ? 18 : 14),
        ));
  }
}
