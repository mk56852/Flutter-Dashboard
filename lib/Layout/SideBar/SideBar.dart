import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/Screens/Dashboard/Dashbaord.dart';
import 'package:point_of_sales/Screens/Financial/FinancialScreen.dart';
import 'package:point_of_sales/Screens/POS/Pos.dart';
import 'package:point_of_sales/Screens/Stock/Stock.dart';
import 'package:point_of_sales/Screens/Users/User.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class SideBar extends StatelessWidget {
  Function handleNavigate;
  SideBar({super.key, required this.handleNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Appcolors.sideBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            offset: Offset(2, 2), // Shadow offset (x, y)
            blurRadius: 2, // Shadow blur radius
            spreadRadius: 1, // Shadow spread radius
          ),
        ],
      ),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SideBarLogo(),
            SideBarItem(
              text: "Admin Dashboard",
              iconData: FontAwesomeIcons.chartBar,
              onClick: () => handleNavigate(Dashbaord()),
            ),
            SideBarItem(
              text: "User Management",
              iconData: FontAwesomeIcons.user,
              onClick: () => handleNavigate(UsersScreen()),
            ),
            SideBarItem(
              text: "Point of Sales",
              iconData: FontAwesomeIcons.cartShopping,
              onClick: () => handleNavigate(Pos()),
            ),
            SideBarItem(
              text: "Stock Management",
              iconData: FontAwesomeIcons.boxesStacked,
              onClick: () => handleNavigate(StockScreen()),
            ),
            SideBarItem(
              text: "Financial",
              iconData: FontAwesomeIcons.moneyBill1,
              onClick: () => handleNavigate(FinancialScreen()),
            ),
            SideBarItem(
              text: "Products",
              iconData: FontAwesomeIcons.boxOpen,
              onClick: () => handleNavigate(Pos()),
            ),
            SideBarItem(
              text: "Reservations",
              iconData: FontAwesomeIcons.calendar,
              onClick: () => handleNavigate(Pos()),
            ),
            SideBarItem(
              text: "Sales",
              iconData: FontAwesomeIcons.chartLine,
              onClick: () => handleNavigate(Pos()),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBarLogo extends StatelessWidget {
  const SideBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child:
          Container(height: 100, child: Image.asset("assets/images/logo.png")),
    );
  }
}

class SideBarItem extends StatefulWidget {
  String text;
  IconData iconData;
  Function onClick;
  SideBarItem(
      {super.key,
      required this.text,
      required this.iconData,
      required this.onClick});
  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  Color c = Appcolors.sideBarTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 13, bottom: 13, left: 35),
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            c = Colors.white;
          });
        },
        onExit: (value) {
          setState(() {
            c = Appcolors.sideBarTextColor;
          });
        },
        child: InkWell(
          onTap: () => widget.onClick(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              FaIcon(
                widget.iconData,
                size: 19,
                color: c,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  color: c,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
