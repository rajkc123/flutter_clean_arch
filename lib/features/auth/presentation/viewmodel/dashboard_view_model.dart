import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/auth/presentation/navigator/dashboard_navigator.dart';

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, void>((ref) {
  final navigator = ref.read(dashboardViewNavigatorProvider);
  return DashboardViewModel(navigator);
});

class DashboardViewModel extends StateNotifier<void> {
  DashboardViewModel(this.navigator) : super(null);
  DashboardNavigator navigator;

}
