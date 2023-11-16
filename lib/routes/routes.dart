import 'package:emergentesapp/ui/InitialApp.dart';
import 'package:emergentesapp/ui/screens/ScreenHome.dart';
import 'package:emergentesapp/ui/screens/ScreenOptions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/ScreenAccount.dart';
import '../ui/screens/ScreenUserLogin.dart';
import '../ui/screens/ScreenUserRegister.dart';


final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const InitialApp();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'initial',
          builder: (BuildContext context, GoRouterState state) {
            return const InitialApp();
          },
        ),
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenRegister();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenHome();
          },
        ),
        GoRoute(
          path: 'options',
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenOptions();
          },
        ),
        GoRoute(
          path: 'account',
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenAccount();
          },
        ),
      ],
    ),
  ],
);