import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_navbar_indexer_state.dart';

class ChangeNavbarIndexerCubit extends Cubit<ChangeNavbarIndexerState> {
  ChangeNavbarIndexerCubit() : super(const ChangeNavbarIndexerState(index: 0));

  void changeIndex(int index) {
    emit(ChangeNavbarIndexerState(index: index));
  }
}
