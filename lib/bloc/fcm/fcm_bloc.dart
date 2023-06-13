import 'package:bwa_cozy/pages/profile/profile_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FCMNotificationBloc
    extends Bloc<FCMNotificationEvent, FCMNotificationState> {
  FCMNotificationBloc() : super(FCMNotificationInitial());

  @override
  Stream<FCMNotificationState> mapEventToState(
      FCMNotificationEvent event) async* {
    if (event is HandleNotificationClickEvent) {
      yield* _handleNotificationClick(event.context, event.remoteMessage);
    }
  }

  Stream<FCMNotificationState> _handleNotificationClick(
      BuildContext context, RemoteMessage remoteMessage) async* {
    String? title = remoteMessage.notification!.title;
    String? description = remoteMessage.notification!.body;

    // Replace the current route with ProfilePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );

    yield FCMNotificationHandledState();
  }
}

// Events
abstract class FCMNotificationEvent {}

class HandleNotificationClickEvent extends FCMNotificationEvent {
  final BuildContext context;
  final RemoteMessage remoteMessage;

  HandleNotificationClickEvent(this.context, this.remoteMessage);
}

// States
abstract class FCMNotificationState {}

class FCMNotificationInitial extends FCMNotificationState {}

class FCMNotificationHandledState extends FCMNotificationState {}
