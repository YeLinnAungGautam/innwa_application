import 'package:equatable/equatable.dart';
import 'package:innwa_mobile_dev/user/model/state_model.dart';
import 'package:innwa_mobile_dev/user/model/township_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.addressDetail,
    this.phone,
    this.state,
    this.township,
    required this.registeredAt,
  });

  final int id;
  final String name;
  final String? image;
  final String email;
  @JsonKey(name: "address_detail")
  final String? addressDetail;
  final String? phone;
  final StateModel? state;
  final TownshipModel? township;
  @JsonKey(name: "registered_at")
  final String registeredAt;

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        email,
        addressDetail,
        phone,
        state,
        township,
        registeredAt
      ];

  UserModel copyWith({
    int? id,
    String? name,
    String? image,
    String? email,
    String? addressDetail,
    String? phone,
    StateModel? state,
    TownshipModel? township,
    String? registeredAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
      addressDetail: addressDetail ?? this.addressDetail,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      township: township ?? this.township,
      registeredAt: registeredAt ?? this.registeredAt,
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
