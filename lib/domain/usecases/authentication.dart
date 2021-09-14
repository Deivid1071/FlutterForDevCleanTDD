import 'package:flutter_for_dev_dm/domain/entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth({
    required String emal,
    required String password,
  });
}
