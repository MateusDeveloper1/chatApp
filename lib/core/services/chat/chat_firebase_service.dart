import 'dart:async';


import 'package:chat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/chat_message.dart';
import '../../model/chat_user.dart';

class ChatFirebaseService implements ChatService {
    Stream<List<ChatMessage>> messagesStream(){
      return Stream<List<ChatMessage>>.empty();
    }



    Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final docRef = await store.collection('chat').add({
      'text':text,
      'createdAt':DateTime.now().toIso8601String(),
      'userId':user.id,
      'userName':user.name,
      'userImageUrl': user.imageUrl,
    });

    final doc = await docRef.get();
    final data = doc.data()!;



    //return ;
  }
      
  }

  

