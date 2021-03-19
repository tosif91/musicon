import 'package:flutter/material.dart';
import 'package:musicon/page/home/home_bloc.dart';
import 'package:stacked/stacked.dart';

class NetworkWidget extends ViewModelWidget<HomeBloc> {
  @override
  Widget build(BuildContext context, HomeBloc model) {
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.network_check_rounded,
            size: 65,
            color: Colors.amber[200],
          ),
          Text(
            'oops!\n no network connection... !',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    ));
  }
}
