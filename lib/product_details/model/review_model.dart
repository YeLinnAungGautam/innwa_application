import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel extends Equatable {
  const ReviewModel(
      {required this.id,
      required this.productId,
      required this.customerId,
      required this.star,
      required this.msg});

  final int id;
  @JsonKey(name: "product_id")
  final int productId;
  @JsonKey(name: "customer_id")
  final int customerId;
  final int star;
  final String msg;

  @override
  List<Object?> get props => throw UnimplementedError();
  ReviewModel copyWith(
      {int? id, int? productId, int? customerId, int? star, String? msg}) {
    return ReviewModel(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        customerId: customerId ?? this.customerId,
        star: star ?? this.star,
        msg: msg ?? this.msg);
  }

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
