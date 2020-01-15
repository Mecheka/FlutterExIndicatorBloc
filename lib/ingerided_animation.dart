import 'package:flutter/material.dart';

class InheritedAnimation extends InheritedWidget {

  final Widget child;
  final selectList = [true];

  InheritedAnimation({this.child}) : super(child: child);

  updateSelect(){

  }

  get select => selectList;

  static InheritedAnimation of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(InheritedAnimation oldWidget) {
    return true;
  }
}
