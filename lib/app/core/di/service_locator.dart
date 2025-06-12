import 'package:get_it/get_it.dart';

import 'package:news_app/app/data/datasources/post_remote_data_source.dart';
import 'package:news_app/app/data/repositories/post_repository.dart';
import 'package:news_app/app/presentation/features/home/cubit/home_cubit.dart';
import 'package:news_app/app/core/network/api_client.dart';
import 'package:news_app/app/core/services/notification/firebase_notification_manager.dart';
import 'package:news_app/app/core/services/notification/notification_protocol.dart';

final GetIt getIt = GetIt.instance;

Future<void> setup() async {
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

  // Register notification manager
  final notificationManager = FirebaseNotificationManager();
  getIt.registerSingleton<INotificationManager>(notificationManager);
  await notificationManager.initialize();
}
