import 'package:flutter/material.dart';
import 'package:point_of_sales/Layout/Header/Header.dart';
import 'package:point_of_sales/Layout/SideBar/SideBar.dart';
import 'package:point_of_sales/Utils/AppColors.dart';
import 'package:point_of_sales/Utils/AppDimension.dart';
import 'package:point_of_sales/Utils/Breakpoint.dart';

class Layout extends StatefulWidget {
  Widget body;
  Layout({super.key, required this.body});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late Widget currentWidget;

  @override
  void initState() {
    currentWidget = widget.body;
    super.initState();
  }

  void handleBody(Widget wid) {
    setState(() {
      currentWidget = wid;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = AppDimension.sideBarDimension;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Appcolors.backgroundColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (screenWidth > Breakpoint.md) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                    constraints: BoxConstraints.tightForFinite(width: width),
                    child: SideBar(
                      handleNavigate: (wid) => handleBody(wid),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 100, child: Header()),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: currentWidget,
                        ),
                      )
                    ],
                  ))
                ],
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container(
                  child: currentWidget,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
