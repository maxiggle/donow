import 'package:flutter/material.dart';
import 'package:todo/features/todo/view/task_home.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case TaskHome.routeName:
      return MaterialPageRoute(builder: (_) => const TaskHome());
    default:
      return MaterialPageRoute(builder: (_) => const TaskHome());
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) pageBuilder,
  RouteSettings settings,
) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, _, __) => pageBuilder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
