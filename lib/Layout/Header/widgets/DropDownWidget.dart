import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class Dropdownwidget extends StatelessWidget {
  IconData iconData;
  double size;
  List<AppDropDownItem> items;
  Dropdownwidget(
      {super.key,
      required this.size,
      required this.iconData,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: FaIcon(
          iconData,
          size: size,
          color: Colors.white,
        ),
        items: items
            .map((item) => DropdownMenuItem<AppDropDownItem>(child: item))
            .toList(),
        onChanged: (value) {},
        dropdownStyleData: DropdownStyleData(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Appcolors.sideBarColor,
          ),
          offset: Offset(-20, -15),
        ),
      ),
    );
  }
}

class AppDropDownItem extends StatelessWidget {
  String title;
  IconData iconData;
  Function onTap;
  AppDropDownItem(
      {super.key,
      required this.iconData,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Icon(iconData, color: Colors.white, size: 18),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
