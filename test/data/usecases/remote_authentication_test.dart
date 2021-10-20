import 'package:faker/faker.dart';
import 'package:flutter_for_dev_dm/domain/helpers/helpers.dart';
import 'package:flutter_for_dev_dm/domain/usecases/usecases.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_for_dev_dm/data/usecases/usecases.dart';
import 'package:flutter_for_dev_dm/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    //sut = system under test
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });
  test(
    'Should call Http Client with correct values',
    () async {
      final params = AuthenticationParams(
          email: faker.internet.email(), secret: faker.internet.password());
      await sut.auth(params);

      verify(
        httpClient.request(
          url: url,
          method: 'post',
          body: {'email': params.email, 'password': params.secret},
        ),
      );
    },
  );

  test(
    'Should throw UnespectError if Http client returns 400',
    () async {
      final params = AuthenticationParams(
          email: faker.internet.email(), secret: faker.internet.password());
      when(
        httpClient.request(
          url: url,
          method: 'post',
          body: {'email': params.email, 'password': params.secret},
        ),
      ).thenThrow(HttpError.badRequest);

      final future = sut.auth(params);

      expect(future, throwsA(DomainError.unexpected));
    },
  );
}
