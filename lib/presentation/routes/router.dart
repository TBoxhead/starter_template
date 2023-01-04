import 'package:auto_route/auto_route.dart';
import 'package:starter_template/presentation/main_page/main_page.dart';
import 'package:starter_template/presentation/sign_in/sign_in_page.dart';
import 'package:starter_template/presentation/splash/splash.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(page: SignInPage),
  AutoRoute(page: MainPage),
  AutoRoute(page: SplashPage, initial: true),
])
class $AppRouter {}
