import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/layout/home_layout.dart';
import 'package:nasa_app/network/cache_helper.dart';
import 'package:nasa_app/screens/login/login.dart';
import 'package:nasa_app/screens/login/onBoarding.dart';
import 'package:nasa_app/shared/component.dart';
import 'all_cubit/login_cubit/cubit.dart';
import 'network/bloc_obserp.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await CacheHelper.init();
  // DioHelper.init();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());

  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  timeago.setLocaleMessages('en', timeago.EnMessages());
  // timeago.setLocaleMessages('en_short', timeago.EnShortMessages());

  uId = await CacheHelper.getData(key: 'uId');
  bool? ifOnBoarding = CacheHelper.getData(key: 'onBoarding');

  Widget? widget;

  if (ifOnBoarding != null) {
    if (uId != null) {
      widget = const NasaLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoarding();
  }


  Bloc.observer = MyBlocObserver();

  // runApp(DevicePreview(
  //  builder: (context) => MyApp(myHome: widget!)));

  runApp(MyApp(myHome: widget));
}

class MyApp extends StatelessWidget {
  final Widget myHome;

  const MyApp({required this.myHome, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => NasaCubit()
                ..checkInternet()
                ..getUserData()
                ..getSomeSecond()
                ..getNasa()
                ..getPosts(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.deepPurple,
              ),
              appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white.withOpacity(0.0),
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.black,
                ),
                color: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              fontFamily: 'Jannah',
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.black.withOpacity(0.8),
              ),
            ),
            themeMode: ThemeMode.light,
            home: myHome,
          ),
        );
      },
    );
  }
}
