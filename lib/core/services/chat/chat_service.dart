import 'package:chat/core/model/chat_message.dart';
import 'package:chat/core/model/chat_user.dart';

import 'chat_firebase_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage?> save(String text, ChatUser user);

  factory ChatService() {
    //return ChatMockService();
    return ChatFirebaseService();
  }
}
