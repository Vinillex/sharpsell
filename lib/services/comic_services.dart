import 'package:dio/dio.dart';
import 'package:sharpsell_app/model/model_page_data.dart';
import 'package:sharpsell_app/util/utl_constants.dart';

class ComicServices {
  final dio = Dio();

  Future<ComicPageData> requestPage(int pageNo) async {
    final response = await dio.get(UrlConstants.infoUrl(pageNo));
    return ComicPageData.fromJson(response.data as Map<String, dynamic>);
  }
}
