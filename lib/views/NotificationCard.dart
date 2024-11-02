import 'package:alternance_flutter/utils/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/Notification.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notification;
  const NotificationCard({super.key,required this.notification});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late bool isRead;

  @override
  void initState() {
    super.initState();
    isRead = widget.notification.isRead;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Move margin here
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: _getReadStatusColor(isRead),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.notification.message,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(
                    DateTime.parse(widget.notification.createdAt.toString()),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _getReadStatusColor(isRead),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isRead = !isRead;
                        // Optionally update the notification's isRead status in the backend or parent widget
                      });
                    },
                    child: Text(
                      isRead ? 'MARK AS UNREAD' : 'MARK AS READ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Color _getReadStatusColor(bool isRead) {
    return isRead ? ColorsUtils.primaryGreen : ColorsUtils.transparentGrey;
  }
}
