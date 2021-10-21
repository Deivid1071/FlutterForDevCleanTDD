import 'package:flutter_for_dev_dm/data/http/http.dart';
import 'package:flutter_for_dev_dm/domain/entities/entities.dart';

class RemoteAccountModel {
  final String acessToken;

  RemoteAccountModel({required this.acessToken});

  factory RemoteAccountModel.fromJson(Map? json) {
    if (json != null) {
      if (!json.containsKey('accessToken')) {
        throw HttpError.ivalidData;
      }
    }

    return RemoteAccountModel(
        acessToken: json != null ? json['accessToken'] : '');
  }

  AccountEntity toEntity() => AccountEntity(token: acessToken);
}
