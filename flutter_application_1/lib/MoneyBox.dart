import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

//Create contrainer Defult
class MoneyBox extends StatelessWidget {
 

  String title; //ชื่อสกุลเงิน
  double amount; // จำนวนเงิน
  Color color;
  double size;

  MoneyBox(this.title,this.amount,this.color,this.size);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Text(
            title,
            style:const TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              '${NumberFormat("#,###.##").format(amount)}',
              style:const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
