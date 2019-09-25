import 'package:redux/redux.dart';

import 'package:pokergame/models/appState.dart';

AppState rootReducer(AppState state, action){
  try {
    return action.reducer(state);
  } catch(e){
    print('Error: $e');
    return state;
  }
}

Store<AppState> getStore() {
  return Store<AppState>(
    rootReducer,
    initialState: AppState(),
  );
}