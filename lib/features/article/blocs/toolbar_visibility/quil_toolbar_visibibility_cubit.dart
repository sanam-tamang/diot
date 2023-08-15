import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'quil_toolbar_visibibility_state.dart';

class QuilToolbarVisibibilityCubit extends Cubit<QuilToolbarVisibibilityState> {
  QuilToolbarVisibibilityCubit() : super(const QuilToolbarVisibibilityState());

  void changeVisibility(bool isQuillToolbarKeyboardVisible) {
    emit(QuilToolbarVisibibilityState(isKeyboardVisibile:  isQuillToolbarKeyboardVisible));
  }
}
