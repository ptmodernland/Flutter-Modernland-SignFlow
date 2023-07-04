import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:modernland_signflow/data/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt.get<Dio>()));
  // Register any other dependencies here
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
}
