import 'package:flutter_for_dev_dm/domain/entities/entities.dart';

class RemoteAccountModel {
  final String acessToken;

  RemoteAccountModel({required this.acessToken});

  factory RemoteAccountModel.fromJson(Map? json) =>
      RemoteAccountModel(acessToken: json != null ? json['accessToken'] : '');

  AccountEntity toEntity() => AccountEntity(token: acessToken);
}
