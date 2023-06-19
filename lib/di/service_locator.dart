import 'package:bwa_cozy/data/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt.get<Dio>()));
  // Register any other dependencies here
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
}
