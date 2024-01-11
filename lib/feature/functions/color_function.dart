import 'package:flutter/material.dart';

class SelectedColor{

  Color? returnColorFromIndex(int index){
    int mod = index % 8;
    if (mod == 1 || mod == 2) {
      return Colors.indigo[50];
    } else if (mod == 3 || mod == 4) {
        return Colors.indigo[100];
    } else if (mod == 5 || mod == 6) {
        return Colors.indigo[200];
    } else if (mod == 7 || mod == 0) {
        return Colors.indigo[300];
    } else {
        return Colors.indigo[900]; 
    }
  }
}