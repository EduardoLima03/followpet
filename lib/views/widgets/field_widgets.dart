import 'package:flutter/material.dart';


class FieldWidgets extends StatelessWidget {
  String value1;
  String value2;
  String label1;
  String label2;
  double sized;

  FieldWidgets(
      {this.value1, this.value2, this.label1, this.label2, this.sized});

  @override
  Widget build(BuildContext context) {
    if (this.label1 != null && this.label2 != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: this.sized * 6.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.label1,
                  style: TextStyle(
                      fontSize: this.sized - 4,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  this.value1,
                  style: TextStyle(
                    fontSize: sized,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
          Container(
            width: this.sized * 6.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.label2,
                  style: TextStyle(
                      fontSize: this.sized - 4,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  this.value2,
                  style: TextStyle(
                    fontSize: sized,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: sized * 6.4,
            child: Text(
              value1,
              style: TextStyle(fontSize: sized),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
            ),
          ),
          Container(
            width: sized * 6.4,
            child: Text(
              value2,
              style: TextStyle(fontSize: sized),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
            ),
          ),
        ],
      );
    }
  }
}
