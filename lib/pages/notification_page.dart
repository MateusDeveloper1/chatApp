import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPAge extends StatelessWidget {
  const NotificationPAge({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificatioService>(context);
    final items = service.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Minhas notificações",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: service.itemsCount,
        itemBuilder: (context, i) => ListTile(
          title: Text(items[i].title),
          subtitle: Text(items[i].body),
          onTap: () => service.remove(i),
        ),
      ),
    );
  }
}
