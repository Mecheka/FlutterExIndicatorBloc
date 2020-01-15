import 'package:bloc/bloc.dart';
import 'package:state_manage/bloc/indicator_event.dart';

class IndicatorBloc extends Bloc<IndicatorEvent, List<bool>> {
  @override
  List<bool> get initialState => [true, false, false, false, false];

  @override
  Stream<List<bool>> mapEventToState(IndicatorEvent event) async* {
    if (event is UpdateIndicator) {
      final List<bool> newSelect = List.from(state);
      newSelect.asMap().forEach((mapIndex, valeu) {
        if (mapIndex == event.index) {
          newSelect[mapIndex] = true;
        } else {
          newSelect[mapIndex] = false;
        }
      });

      yield newSelect;
    }
  }
}
