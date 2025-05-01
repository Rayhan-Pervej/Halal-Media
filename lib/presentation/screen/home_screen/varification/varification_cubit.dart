import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'varification_state.dart';

class VarificationCubit extends Cubit<VarificationState> {
  Timer? _timer;
  int _seconds = 60;

  VarificationCubit() : super(VarificationInitial());

  Future<void> varification(BuildContext context) async {
    emit(ContinueLoading());

    // Simulate API
    await Future.delayed(const Duration(seconds: 2));

    emit(ContinueSuccess());
  }

  /// Handles Resend Email Button
  Future<void> resendVerificationEmail() async {
    emit(ResendLoading());

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    startResendCountdown();
    emit(ResendSent());
  }

  void startResendCountdown() {
    _seconds = 60;
    emit(ResendCountdownState(_seconds));

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds--;
      if (_seconds <= 0) {
        timer.cancel();
        emit(ResendEnabledState());
      } else {
        emit(ResendCountdownState(_seconds));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
