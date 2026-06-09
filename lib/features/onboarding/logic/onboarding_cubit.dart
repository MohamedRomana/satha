import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// كيوبت الأونبوردنق — يتتبّع الصفحة الحالية فقط.
class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  final pageController = PageController();

  void onPageChanged(int page) => emit(page);

  void goTo(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
