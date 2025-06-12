abstract class INotificationManager {
  /// Initialize notification service
  Future<void> initialize();

  /// Request notification permissions
  Future<bool> requestPermission();

  /// Show local notification
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
    Map<String, dynamic>? data,
  });

  /// Show notification with custom channel
  Future<void> showNotificationWithChannel({
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    String? payload,
    Map<String, dynamic>? data,
  });

  /// Cancel notification by id
  Future<void> cancelNotification(int id);

  /// Cancel all notifications
  Future<void> cancelAllNotifications();

  /// Get notification token
  Future<String?> getToken();

  /// Handle notification tap
  void onNotificationTap(Function(Map<String, dynamic> data) callback);

  /// Handle notification received
  void onNotificationReceived(Function(Map<String, dynamic> data) callback);
}
