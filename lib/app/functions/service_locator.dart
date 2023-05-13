import 'package:get_it/get_it.dart';
import 'package:meminder/core/network/base_client.dart';
import 'package:meminder/features/meme/bloc/meme_bloc.dart';
import 'package:meminder/features/meme/services/meme_repo.dart';
import 'package:meminder/features/meme/services/meme_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  locator.registerSingleton<SharedPreferences>(preferences);
  locator.registerFactory<NetworkBaseClient>(() => NetworkBaseClient());

  ///repos and classes
  locator.registerFactory<MemeRepo>(() => MemeServices(locator()));
  locator.registerLazySingleton(() => MemeBloc(locator()));
}
