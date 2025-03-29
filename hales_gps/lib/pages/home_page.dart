import 'package:flutter/material.dart';
import 'package:hales_gps/theme.dart';
import 'maps_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

