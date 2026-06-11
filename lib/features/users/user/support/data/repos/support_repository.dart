import '../models/support_models.dart';

/// واجهة مستودع الدعم.
abstract class SupportRepository {
  List<FaqModel> getFaqs();
  SupportContactModel getContact();
  Future<void> submitComplaint(ComplaintModel complaint);
  Future<void> submitContactMessage(String name, String email, String message);
}
