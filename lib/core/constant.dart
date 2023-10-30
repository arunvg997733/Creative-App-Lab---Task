import 'package:flutter/material.dart';

Widget textWidget({required String text,required double size,required Color color,FontWeight? weight}){
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight
    ),);
}


const kBlack = Colors.black;
const kwhite = Colors.white;
const kGrey = Colors.grey;
const kRed = Colors.red;
const kOrange = Colors.orange;
const kBlue = Colors.blue;



const kHeight10 = SizedBox(height: 10);
const kHeight20 = SizedBox(height: 20);
const kHeight30 = SizedBox(height: 30);

const kWidth10 = SizedBox(width: 10);
const kWidth20 = SizedBox(width: 20);
const kWidth30 = SizedBox(width: 30);