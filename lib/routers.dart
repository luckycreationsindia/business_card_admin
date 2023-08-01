import 'package:business_card_admin/src/screens/add_customer.dart';
import 'package:business_card_admin/src/screens/dashboard.dart';
import 'package:business_card_admin/src/screens/list_customer.dart';
import 'package:business_card_admin/src/screens/login.dart';
import 'package:business_card_admin/src/screens/update_customer.dart';
import 'package:business_card_admin/src/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage withCustomAnimation(
    GoRouterState state, Widget child, int selectedIndex) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: MainWrapper(
      selectedIndex: selectedIndex,
      child: child,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

final routerList = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) {
        return withCustomAnimation(state, const DashboardScreen(), 0);
      },
    ),
    GoRoute(
      path: '/add_customer',
      pageBuilder: (context, state) {
        return withCustomAnimation(state, const AddCustomerScreen(), 1);
      },
    ),
    GoRoute(
      path: '/list_customer',
      pageBuilder: (context, state) {
        return withCustomAnimation(state, const CustomerListScreen(), 2);
      },
    ),
    GoRoute(
      path: '/customer/:id',
      pageBuilder: (context, state) {
        return withCustomAnimation(
            state,
            UpdateCustomerScreen(
              id: state.pathParameters['id']!,
            ),
            -1);
      },
    ),
  ],
);
