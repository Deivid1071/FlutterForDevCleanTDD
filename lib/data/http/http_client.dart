abstract class HttpClient {
  Future<Map<String, dynamic>>? request(
      {required String url, required method, required Map body}) async {
    return {};
  }
}
