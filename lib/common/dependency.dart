import 'package:get/get.dart';
import 'package:test_app/datasource/movie/movie_datasource_impl.dart';

class Dependency {
  static void initDataSources() {
    Get.lazyPut(() => MovieDataSourceImpl(), fenix: true);
  }
}
