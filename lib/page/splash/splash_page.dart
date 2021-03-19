import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musicon/page/splash/splash_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashBloc>.nonReactive(
        viewModelBuilder: () => SplashBloc(),
        // onModelReady: (model) => model.initialize(),
        builder: (context, model, _) => Scaffold(
              body: Container(
                child: Center(
                  child: TypewriterAnimatedTextKit(
                    totalRepeatCount: 1,
                    speed: Duration(milliseconds: 250),
                    textStyle: TextStyle(
                        // color: Colors.purple[900],
                        fontSize: 40.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 3.0),
                    text: ['Music On'],
                    repeatForever: false,
                    onFinished: () => model.initialize(),
                    // waveColor: Colors.purple[900],
                    // boxBackgroundColor: Colors.white,
                  ),
                ),
              ),
            ));
  }
}
