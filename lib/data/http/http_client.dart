abstract class HttpClient {
  Future<void>? request(
      {required String url, required method, required Map body}) async {}
}