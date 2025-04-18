import 'package:aloha_mobile/add_task.dart';
import 'package:aloha_mobile/chat.dart';
import 'package:aloha_mobile/chat_details.dart';
import 'package:aloha_mobile/constants.dart';
import 'package:aloha_mobile/home.dart';
import 'package:aloha_mobile/notebook.dart';
import 'package:aloha_mobile/social.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(providers: [ ChangeNotifierProvider(create: (_) => FriendProvider()),], child: const MyApp()));
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => MyHomePage()),
    GoRoute(path: '/notebook', builder: (context, state) => NotebookPage()),
    GoRoute(
      path: '/notebook/addTask',
      builder: (context, state) => AddTaskScreen(),
    ),
    GoRoute(path: '/chat', builder: (context, state) => ChatPage()),
    GoRoute(path: '/chat/details', builder: (context, state) => ChatDetails(                   user: ChatUsers(
                    name: "Jane Russel",
                    location: 'London, UK',
                    messageText: "Awesome Setup",
                    imageURL: "assets/profiles/userImage1.png",
                    time: "Now",
                  ),)),
    GoRoute(path: '/social', builder: (context, state) => SocialPage()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aloha',
      theme: ThemeData(useMaterial3: true),
      routerConfig: _router,
      // home: CustomPaint(painter: CirclePainter()),
    );
  }
}

// class CirclePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint =
//         Paint()
//           ..color = Colors.redAccent
//           ..strokeWidth = 2
//           ..style = PaintingStyle.stroke
//           ..strokeCap = StrokeCap.round;

//     var path = Path();
//     path.moveTo(0, size.height / 2);
//     path.lineTo(size.width, size.height / 2);
//     canvas.drawPath(path, paint);

//     Offset s = Offset(size.width / 2, 0);
//     Offset e = Offset(size.width / 2, size.height);
//     canvas.drawLine(s, e, paint);

//     Offset center = Offset(size.width / 2, size.height / 2);
//     canvas.drawCircle(center, 100, paint);

//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }
