import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/auth/presentation/navigator/login_navigator.dart';

final splashViewNavigatorProvider =
    Provider<SplashViewNaviagtor>((ref) => SplashViewNaviagtor());// object 

class SplashViewNaviagtor with LoginViewRoute {} //open from splash screen

mixin SplashViewRoute {} // used for opening splash screen 
