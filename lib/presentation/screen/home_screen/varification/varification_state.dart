part of 'varification_cubit.dart';

@immutable
sealed class VarificationState {}

class VarificationInitial extends VarificationState {}

/// ───── CONTINUE STATES ─────
class ContinueLoading extends VarificationState {}
class ContinueSuccess extends VarificationState {}

/// ───── RESEND STATES ─────
class ResendCountdownState extends VarificationState {
  final int secondsRemaining;
  ResendCountdownState(this.secondsRemaining);
}

class ResendEnabledState extends VarificationState {}

class ResendLoading extends VarificationState {}
class ResendSent extends VarificationState {}