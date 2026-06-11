/// فاتورة طلب مكتمل.
class InvoiceModel {
  final String invoiceNumber;
  final String orderNumber;
  final DateTime date;
  final String customerName;
  final String driverName;
  final String vehicleName;
  final String serviceLabel;
  final String pickupAddress;
  final String destinationAddress;
  final double distanceKm;
  final int durationMin;
  final num price;
  final num discount;
  final String paymentMethod;
  final bool paid;

  const InvoiceModel({
    required this.invoiceNumber,
    required this.orderNumber,
    required this.date,
    required this.customerName,
    required this.driverName,
    required this.vehicleName,
    required this.serviceLabel,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.distanceKm,
    required this.durationMin,
    required this.price,
    required this.discount,
    required this.paymentMethod,
    required this.paid,
  });

  num get total => price - discount;
}
