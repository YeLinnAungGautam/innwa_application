// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      addressDetail: json['address_detail'] as String?,
      phone: json['phone'] as String?,
      state: json['state'] == null
          ? null
          : StateModel.fromJson(json['state'] as Map<String, dynamic>),
      township: json['township'] == null
          ? null
          : TownshipModel.fromJson(json['township'] as Map<String, dynamic>),
      registeredAt: json['registered_at'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'email': instance.email,
      'address_detail': instance.addressDetail,
      'phone': instance.phone,
      'state': instance.state,
      'township': instance.township,
      'registered_at': instance.registeredAt,
    };
