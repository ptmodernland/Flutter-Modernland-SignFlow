import 'package:bwa_cozy/bloc/login/login_payload.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NotifCoreEvent {}

class NotifEventCount extends NotifCoreEvent {
  NotifEventCount();
}
