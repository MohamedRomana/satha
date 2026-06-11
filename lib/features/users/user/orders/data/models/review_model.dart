/// تقييم عميل سابق للسائق.
class ReviewModel {
  final String id;
  final String customerName;
  final String? customerImage;
  final double rating;
  final String? comment;
  final DateTime date;

  const ReviewModel({
    required this.id,
    required this.customerName,
    required this.rating,
    required this.date,
    this.customerImage,
    this.comment,
  });
}
