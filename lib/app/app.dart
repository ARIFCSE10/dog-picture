import 'package:dog_picture/app/bloc/notification/notification_bloc.dart';
import 'package:dog_picture/app/observer/app_life_cycle_observer.dart';
import 'package:dog_picture/app/routes/route_generator.dart';
import 'package:dog_picture/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogPictureApp extends StatefulWidget {
  const DogPictureApp({super.key});

  @override
  State<DogPictureApp> createState() => _DogPictureAppState();
}

class _DogPictureAppState extends State<DogPictureApp> {
  late NotificationBloc _notificationBloc;
  late BlocProvider<NotificationBloc> _notificationBlocProvider;

  @override
  void initState() {
    super.initState();
    _notificationBloc = NotificationBloc();
    _notificationBlocProvider = BlocProvider<NotificationBloc>(
      lazy: false,
      create: (BuildContext context) {
        return _notificationBloc;
      },
    );
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        _notificationBlocProvider,
      ],
      child: AppLifeCycleObserver(
        child: MaterialApp(
          title: 'Dog Picture App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xFF2196f3),
            canvasColor: const Color(0xFFfafafa),
          ),
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: Routes.index,
          builder: (BuildContext ctx, Widget? child) {
            return Scaffold(
              body: BlocListener<NotificationBloc, NotificationState>(
                listener: (BuildContext context, NotificationState state) {
                  if (state is SuccessNotificationState) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.greenAccent,
                      ),
                    );
                  } else if (state is ErrorNotificationState) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${state.message}'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
