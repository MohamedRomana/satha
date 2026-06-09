import 'package:flutter_bloc/flutter_bloc.dart';

/// كيوبت الـ bottom navigation — يحفظ التبويب الحالي (0..4).
class MainLayoutCubit extends Cubit<int> {
  MainLayoutCubit() : super(0);

  void changeTab(int index) {
    if (index != state) emit(index);
  }
}
