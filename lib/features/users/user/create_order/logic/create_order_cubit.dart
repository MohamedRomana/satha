import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../orders/data/models/order_model.dart';
import '../../vehicles/data/models/vehicle_model.dart';
import '../../vehicles/data/repos/vehicles_repository.dart';
import '../data/models/location_models.dart';
import '../data/models/order_flow_models.dart';

/// كيوبت تدفّق إنشاء الطلب — يحفظ المسودّة عبر الخطوات.
/// الحالة عدّاد (tick) يتغيّر مع كل تحديث لإعادة بناء الواجهة.
class CreateOrderCubit extends Cubit<int> {
  final VehiclesRepository _vehiclesRepo;
  CreateOrderCubit(this._vehiclesRepo) : super(0) {
    loadVehicles();
  }

  static const int totalSteps = 5;
  final pageController = PageController();
  final descriptionController = TextEditingController();

  int currentStep = 0;

  // ---- المسودّة ----
  OrderServiceType? service;
  VehicleModel? vehicle;
  OrderProblemType? problem;
  final List<File> problemImages = [];

  // ---- المواقع (المرحلة 4) ----
  LocationModel? pickup;
  LocationModel? destination;
  RouteInfoModel? route;

  void setLocations({
    LocationModel? pickup,
    LocationModel? destination,
    RouteInfoModel? route,
  }) {
    this.pickup = pickup;
    this.destination = destination;
    this.route = route;
    _refresh();
  }

  /// تجهيز مسودّة طلب من البيانات المُدخلة (تُرسَل لشاشة الملخّص).
  OrderModel buildDraft() => OrderModel(
    id: '',
    orderNumber: '',
    status: OrderStatus.draft,
    service: service!,
    vehicle: vehicle!,
    problem: problem!,
    description: descriptionController.text.trim().isEmpty
        ? null
        : descriptionController.text.trim(),
    problemImages: problemImages.map((f) => f.path).toList(),
    pickup: pickup!,
    destination: destination!,
    route: route!,
    createdAt: DateTime.now(),
  );

  bool get hasLocations => pickup != null && destination != null && route != null;

  // ---- بيانات السيارات ----
  bool loadingVehicles = false;
  List<VehicleModel> vehicles = [];

  int _tick = 0;
  void _refresh() => emit(++_tick);

  Future<void> loadVehicles() async {
    loadingVehicles = true;
    _refresh();
    vehicles = await _vehiclesRepo.getVehicles();
    // اختيار الافتراضية تلقائيًا إن لم يُختر شيء.
    if (vehicle == null && vehicles.isNotEmpty) {
      vehicle = vehicles.firstWhere(
        (v) => v.isDefault,
        orElse: () => vehicles.first,
      );
    }
    loadingVehicles = false;
    if (isClosed) return;
    _refresh();
  }

  void selectService(OrderServiceType type) {
    service = type;
    _refresh();
  }

  void selectVehicle(VehicleModel v) {
    vehicle = v;
    _refresh();
  }

  void selectProblem(OrderProblemType p) {
    problem = p;
    _refresh();
  }

  void addImage(File file) {
    if (problemImages.length >= 4) return;
    problemImages.add(file);
    _refresh();
  }

  void removeImage(int index) {
    if (index >= 0 && index < problemImages.length) {
      problemImages.removeAt(index);
      _refresh();
    }
  }

  bool canProceed(int step) {
    switch (step) {
      case 0:
        return service != null;
      case 1:
        return vehicle != null;
      case 2:
        return problem != null;
      default:
        return true;
    }
  }

  void next() {
    if (currentStep >= totalSteps - 1) return;
    currentStep++;
    pageController.animateToPage(
      currentStep,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
    _refresh();
  }

  void back() {
    if (currentStep <= 0) return;
    currentStep--;
    pageController.animateToPage(
      currentStep,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
    _refresh();
  }

  @override
  Future<void> close() {
    pageController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
