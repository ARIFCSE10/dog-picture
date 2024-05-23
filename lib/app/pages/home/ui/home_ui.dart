import 'package:dog_picture/app/bloc/notification/notification_bloc.dart';
import 'package:dog_picture/app/pages/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  late HomeBloc _bloc;

  List<String>? dogBreeds;

  @override
  void initState() {
    _bloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<HomeBloc>(
        create: (BuildContext context) => _bloc,
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (BuildContext context, HomeState state) {
            if (state is HomeErrorState) {
              BlocProvider.of<NotificationBloc>(context)
                  .add(ErrorNotificationEvent(state.error));
            } else if (state is DogBreedListApiSuccessfulState) {
              setState(() {
                dogBreeds == state.dogBreeds;
              });
            }
          },
          builder: (BuildContext context, HomeState state) {
            if (state is HomeLoadingState || state is HomeInitial) {
              return Center(
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: const Text(
                      'Shimmer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
