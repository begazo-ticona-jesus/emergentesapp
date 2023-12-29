import 'package:emergentesapp/presentation/screens/account/ScreenAccount.dart';
import 'package:emergentesapp/presentation/screens/home/ScreenHome.dart';
import 'package:emergentesapp/presentation/screens/userRegister/ScreenUserRegister.dart';
import 'package:emergentesapp/presentation/InitialApp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



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
          path: 'account',
          builder: (BuildContext context, GoRouterState state) {
            return const ScreenAccount();
          },
        ),
      ],
    ),
  ],
);