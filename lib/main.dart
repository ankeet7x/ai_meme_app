import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meminder/app/functions/feedback_cubit/feedback_cubit.dart';
import 'package:meminder/app/functions/route_generator.dart';
import 'package:meminder/app/functions/service_locator.dart';
import 'package:meminder/app/themes/light_theme.dart';
import 'package:meminder/features/meme/bloc/meme_bloc.dart';
import 'package:meminder/features/meme/screens/meme_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  lockOrientation();
  runApp(const MyApp());
}

lockOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FeedbackCubit()..initialize(),
            ),
            BlocProvider.value(
              value: locator<MemeBloc>()..add(ReadMemeJsonFilesEvent()),
            )
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: MemeHomePage.pageUrl,
            title: "Meminder",
            theme: lightTheme,
            onGenerateRoute: RouteGenerator.generateRoutes,
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: widget!,
              );
            },
          ),
        );
      },
    );
  }
}
