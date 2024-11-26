import 'package:dio/dio.dart';
import 'package:sharpsell_app/model/model_page_data.dart';

class ComicServices {
  final dio = Dio();

  final url = 'https://xkcd.com/'; //1/info.0.json";

  Future<ComicPageData> requestPage(int pageNumber) async {
    final response = await dio.get('$url$pageNumber/info.0.json');
    return ComicPageData.fromJson(response.data as Map<String, dynamic>);
  }
}
