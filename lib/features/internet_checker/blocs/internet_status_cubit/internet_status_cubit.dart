import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enum/internet_state_enum.dart';

part 'internet_status_state.dart';

class InternetStatusCubit extends Cubit<InternetStatusState> {
  late StreamSubscription _stream;

  InternetStatusCubit()
      : super(const InternetStatusState(status: InternetState.none)) {
  
    _stream = Connectivity().onConnectivityChanged
        .listen((result) {
        _update();
     
    });
        _update();

  }

  Future<void> _update() async{
   final connection =  await   Connectivity().checkConnectivity();
   
    emit(InternetStatusState(status: connection == ConnectivityResult.none? InternetState.disConected:InternetState.connected));
  }

  @override
  Future<void> close() {
    _stream.cancel();
    return super.close();
  }
}
