import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/login_screen.dart';
import 'package:kezzle/features/authentication/make_user_screen.dart';
import 'package:kezzle/responsive/mobile_screen_layout.dart';

final router = GoRouter(
  // initialLocation: "/home",
  routes: [
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: MakeUserScreen.routeName,
      path: MakeUserScreen.routeURL,
      builder: (context, state) => const MakeUserScreen(),
    ),
    GoRoute(
      path: "/:tab(home|map|search|favorite|profile)",
      name: MobileScreenLayout.routeName,
      builder: (context, state) {
        // final tab = state.params['tab']!;
        final tab = state.pathParameters['tab']!;
        return MobileScreenLayout(tab: tab);
      },
    ),
  ],
);
