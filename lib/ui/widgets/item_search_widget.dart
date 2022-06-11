import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemSearchWidget extends StatelessWidget {

  String text;
  ItemSearchWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20.0,
      ),
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50.0,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Icon(
            Icons.north_west_outlined,
            color: Colors.white,
            size: 18.0,
          ),
        ],
      ),
    );
  }
}