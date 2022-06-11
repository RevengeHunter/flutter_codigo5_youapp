import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';

class ItemFilterWidget extends StatelessWidget {

  String text;
  bool isSelected;

  ItemFilterWidget({required this.text, required this.isSelected,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: Chip(
        backgroundColor: isSelected == true ? Colors.white : kBrandSecondaryColor,
        label: Text(
          text,
          style: TextStyle(
            color: isSelected == true ? kBrandSecondaryColor : Colors.white,
          ),
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
