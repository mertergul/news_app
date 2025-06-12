import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../../data/datasources/post_remote_data_source.dart';
import '../../data/repositories/post_repository.dart';
import '../../presentation/features/home/cubit/home_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // ApiClient - Singleton
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // PostRemoteDataSource - Singleton
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSource(getIt<ApiClient>()),
  );

  // PostRepository - Singleton
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepository(getIt<PostRemoteDataSource>()),
  );

  // HomeCubit - Factory
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<PostRepository>()));
}
