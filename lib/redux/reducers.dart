import 'package:reduxapp/redux/actions.dart';
import 'package:reduxapp/redux/app_state.dart';

AppState reducer(AppState prev, dynamic action) {
  if (action is FetchTimeAction) {
    return AppState(action.location, action.time);
  } else {
    return prev;
  }
}
