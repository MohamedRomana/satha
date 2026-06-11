import '../models/support_models.dart';
import 'support_repository.dart';

/// مستودع دعم وهمي.
class MockSupportRepository implements SupportRepository {
  @override
  List<FaqModel> getFaqs() => const [
    FaqModel(
      question: 'كيف أطلب سطحة؟',
      answer:
          'من الشاشة الرئيسية اضغط على "اطلب سطحة الآن"، ثم اختر نوع الخدمة وسيارتك وحدد المشكلة وموقعك، وسيتم إرسال طلبك للسائقين القريبين.',
    ),
    FaqModel(
      question: 'كيف أضيف سيارة جديدة؟',
      answer:
          'من تبويب "سياراتي" اضغط على زر الإضافة، ثم أدخل بيانات السيارة وصورتها واحفظها.',
    ),
    FaqModel(
      question: 'كيف أختار عرض السائق؟',
      answer:
          'بعد إرسال الطلب ستظهر لك عروض السائقين القريبين، راجع التقييم والسعر والمسافة ثم اضغط "قبول العرض" للعرض المناسب.',
    ),
    FaqModel(
      question: 'هل يمكنني إلغاء الطلب؟',
      answer:
          'نعم، يمكنك إلغاء الطلب من شاشة تفاصيل الطلب طالما لم تبدأ الرحلة بعد.',
    ),
    FaqModel(
      question: 'كيف أتابع موقع السائق؟',
      answer:
          'بعد قبول العرض يمكنك متابعة موقع السائق لحظة بلحظة على الخريطة من شاشة تتبّع الطلب.',
    ),
    FaqModel(
      question: 'ما الفرق بين السطحة العادية والهيدروليك؟',
      answer:
          'السطحة العادية مناسبة لمعظم السيارات، بينما السطحة الهيدروليك مخصّصة للسيارات الرياضية والفاخرة ومنخفضة الارتفاع.',
    ),
  ];

  @override
  SupportContactModel getContact() => const SupportContactModel(
    phone: '920000000',
    whatsapp: '966500000000',
    email: 'support@sat7a.app',
  );

  @override
  Future<void> submitComplaint(ComplaintModel complaint) async {
    await Future.delayed(const Duration(milliseconds: 700));
  }

  @override
  Future<void> submitContactMessage(
    String name,
    String email,
    String message,
  ) async {
    await Future.delayed(const Duration(milliseconds: 700));
  }
}
