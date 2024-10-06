import 'package:alternance_flutter/model/Notification.dart';
import 'package:alternance_flutter/service/notification/NotificationService.dart';
import 'package:alternance_flutter/views/NoData.dart';
import 'package:alternance_flutter/views/NotificationCard.dart';
import 'package:flutter/material.dart';

import '../utils/SharedPreferencesUtils.dart';


class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late int userId;
  late Future<List<NotificationModel>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  // Initialize shared preferences and set the userId
  Future<void> _initializePreferences() async {
    await SharedPreferencesUtils.init();
    setState(() {
      userId = SharedPreferencesUtils.getValue<int>("id")!;
      _notificationsFuture = NotificationService().fetchNotificationsByUserId(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
      child: FutureBuilder<List<NotificationModel>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Nodata(filed: "No notifications"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Nodata(filed: "No notifications"));
          } else {
            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(notification: notification);
              },
            );
          }
        },
      ),
    );
  }
}