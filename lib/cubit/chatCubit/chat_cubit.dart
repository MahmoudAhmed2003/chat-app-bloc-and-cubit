import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/models/message.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  ChatCubit() : super(ChatInitial());
  void sendMessage({
    required String msg,
    required String email,
  }) {
    try {
      messages.add(
        {kMessage: msg, kCreatedAt: DateTime.now(), 'id': email},
      );
    } on Exception catch (e) {
      // TODO
    }
    getMessages();
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> list = [];
      log(event.docs.asMap().toString());
      for (var item in event.docs) {
        list.add(Message.fromJson(item));
      }
      log(list.toString());
      emit(ChatSuccess(list));
    });
  }
}
