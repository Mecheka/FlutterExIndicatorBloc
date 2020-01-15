import 'package:equatable/equatable.dart';

abstract class IndicatorEvent extends Equatable {
  List<bool> select;

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateIndicator extends IndicatorEvent {
  final int index;

  UpdateIndicator({this.index});

  @override
  String toString() {
    return 'UpdateIndicator';
  }
}
