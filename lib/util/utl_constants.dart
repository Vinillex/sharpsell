class UrlConstants {
  static const baseUrl = 'https://xkcd.com';

  static const infoPath = '/info.0.json';

  static String infoUrl(int pageNo) {
    return '$baseUrl/$pageNo$infoPath';
  }
}
