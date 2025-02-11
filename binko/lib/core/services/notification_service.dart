// import 'dart:async';
// import 'dart:developer';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../features/orders/presentation/pages/orders_details_screen.dart';
// import '../../firebase_options.dart';
// import '../../router/go_route.dart';
// import '../constants/enums/notification_type_enum.dart';
// import '../extensions/log_colors_extension.dart';
// import '../utils/toaster.dart';
// import 'shared_preferences_service.dart';

// class NotificationUtils {
//   NotificationUtils._();

//   factory NotificationUtils() => _instance;
//   static final NotificationUtils _instance = NotificationUtils._();
//   static final AwesomeNotifications awesomeNotifications =
//       AwesomeNotifications();

//   /// while creating channel do not mistake for creating channel key or not confusing with channel key create same channel key and use for notification
//   /// one more thing prevent with null value or like null string because it will be giving error like native java null pointer exception so be care full
//   /// while passing a data or creating a notification..
//   void listen() {
//     FirebaseMessaging.onMessage.listen((m) async {
//       log('On Message');
//       await listenToNotification(m);
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage m) async {
//       log('On Message Opened');
//       Toaster.showNotification(
//         leading: SizedBox(),
//         title: m.notification?.title ?? '',
//       );
//     });
//   }

//   static Future<void> listenToNotification(RemoteMessage m) async {
//     log('on background');

//     await awesomeNotifications.createNotification(
//         content: NotificationContent(
//             id: -1,
//             channelKey: 'basic_channel',
//             title: m.notification?.title,
//             body: m.notification?.body,
//             payload: m.data.cast()),
//         actionButtons: []);
//     return;
//   }

//   Future<void> configuration() async {
//     try {
//       await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       );
//       final fcm = await FirebaseMessaging.instance.getToken();
//       await SharedPreferencesService.storeFcmToken(fcm ?? '');
//       log('FCM token $fcm'.logWhite);

//       await awesomeNotifications.initialize(
//           null,
//           [
//             NotificationChannel(
//               channelKey: 'basic_channel',
//               channelName: 'Basic Notifications',
//               defaultColor: const Color(0xffBF956B),
//               importance: NotificationImportance.High,
//               channelShowBadge: true,
//               onlyAlertOnce: true,
//               channelDescription: 'Basic Instant Notification',
//             ),
//           ],
//           debug: true);
//       listen();
//     } catch (e) {}
//   }

//   void checkingPermissionNotification(BuildContext context) {
//     AwesomeNotifications().isNotificationAllowed().then(
//       (isAllowed) async {
//         if (!isAllowed) {
//           await AwesomeNotifications().requestPermissionToSendNotifications();
//         }},
//     );
//   }

//   Future<void> checkAppTrakcingTransparency() async {
//     print('checking');
//     final status = await AppTrackingTransparency.requestTrackingAuthorization();
//     print(status);
//   }

//   Future<void> createLocalInstantNotification() async {
//     await awesomeNotifications.createNotification(
//       content: NotificationContent(
//           id: -1,
//           channelKey: 'android',
//           title: 'Buy Favorite Product',
//           body: "Hurry Up To Grab This Product Loot With Just 80% Off",
//           bigPicture:
//               'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
//           largeIcon: 'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
//           notificationLayout: NotificationLayout.BigPicture,
//           payload: {'notificationId': '1234567890'}),
//     );
//   }

//   Future<void> jsonDataNotification(Map<String, Object> jsonData) async {
//     await awesomeNotifications.createNotificationFromJsonData(jsonData);
//   }

//   Future<void> createScheduleNotification() async {
//     try {
//       await awesomeNotifications.createNotification(
//         schedule: NotificationCalendar(
//           day: DateTime.now().day,
//           month: DateTime.now().month,
//           year: DateTime.now().year,
//           hour: DateTime.now().hour,
//           minute: DateTime.now().minute + 1,
//         ),
//         content: NotificationContent(
//           id: -1,
//           channelKey: 'android',
//           title: 'Start Sale In Just Two Min Ago',
//           body: "Hurry Sale Is Now Live Grab The Loot",
//           bigPicture:
//               'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
//           notificationLayout: NotificationLayout.BigPicture,
//         ),
//       );
//     } catch (e) {}
//   }

//   Future<void> createCustomNotificationWithActionButtons() async {
//     await awesomeNotifications.createNotification(
//         content: NotificationContent(
//             id: -1,
//             channelKey: 'android',
//             title: 'Buy Favorite Product',
//             body: "Hurry Up To Grab This Product Loot With Just 80% Off",
//             bigPicture:
//                 'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
//             largeIcon: 'https://rukminim2.flixcart.com/image/612/612/xif0q/sweatshirt/p/i/p/m-839-3-ftx-original-imagvbmpzzreycyg.jpeg?q=70',
//             notificationLayout: NotificationLayout.BigPicture,
//             payload: {'notificationId': '1234567890'}),
//         actionButtons: []);
//   }

//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     log("check data with receivedAction${RouteConfigs.rootNavigatorKey.currentState}");
//     log("check data with receivedAction${RouteConfigs.rootNavigatorKey.currentContext}");
//     if (receivedAction.payload?['type'] ==
//         NotificationTypeEnum.order.index.toString()) {
//       RouteConfigs.rootNavigatorKey.currentContext!.go(RouteConfigs.homeScreen);
//       showGeneralDialog(
//         context: RouteConfigs.rootNavigatorKey.currentContext!,
//         pageBuilder: (context, animation, secondaryAnimation) =>
//             OrderDetailsScreen(
//           id: int.parse(
//               receivedAction.payload!['notification_type_id']!.toString()),
//         ),
//       );
//     } else if (receivedAction.payload?['type'] ==
//         NotificationTypeEnum.product.index.toString()) {
//       RouteConfigs.rootNavigatorKey.currentContext!.go(RouteConfigs.homeScreen);
//       RouteConfigs.rootNavigatorKey.currentContext!.pushNamed(
//         RouteConfigs.productDetailsScreen,
//         extra: int.parse(
//             receivedAction.payload!['notification_type_id']!.toString()),
//       );
//     } else if (receivedAction.payload?['type'] ==
//         NotificationTypeEnum.ticket.index.toString()) {
//       RouteConfigs.rootNavigatorKey.currentContext!.go(RouteConfigs.homeScreen);
//       RouteConfigs.rootNavigatorKey.currentContext!.pushNamed(
//         RouteConfigs.supportTickets,
//       );
//     } else {
//       RouteConfigs.rootNavigatorKey.currentContext!.go(RouteConfigs.homeScreen);
//     }
//   }

//   Future<void> startListeningNotificationEvents() async {
//     log("check data with start listening");
//     AwesomeNotifications().setListeners(
//         onActionReceivedMethod: onActionReceivedMethod,
//         onNotificationCreatedMethod: onNotificationCreatedMethod,
//         onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//         onDismissActionReceivedMethod: onDismissActionReceivedMethod);
//   }

//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     log("onNotificationCreatedMethod");

//     // Your code goes here
//   }

//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//     log("onNotificationDisplayedMethod");
//   }

//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     log("onDismissActionReceivedMethod");
//   }
// }
