import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';

class genLoginSignupHeader extends StatelessWidget {
  String headerName;

  genLoginSignupHeader(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10.0),
          Text(
            headerName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 25.0),
          ),
          SizedBox(height: 1.0),
          Image.asset(
            logo,
            height: 150.0,
            width: 200,
          ),
          SizedBox(height: 15.0),
          Text(
            "Money Manager",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black38,
                fontSize: 25.0),
          ),
        ],
      ),
    );
  }
}
