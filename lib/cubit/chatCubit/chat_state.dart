part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {
  
}
final class ChatSuccess extends ChatState {
  final List<Message> msgList;
  ChatSuccess(this.msgList);
}
