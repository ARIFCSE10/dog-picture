import 'package:dartz/dartz.dart';
import 'package:dog_picture/app/pages/home/repo/home_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on((DogBreedListDataInitLoadEvent event, Emitter<HomeState> emit) async {
      emit(HomeLoadingState());
      await _getDogBreedList().then((HomeState state) => emit(state));
    });
  }

  final HomeRepo _repo = HomeRepo();

  Future<HomeState> _getDogBreedList() async {
    final Either<String, List<String>?> result = await _repo.getDogBreedList();
    return result.fold((String? error) {
      return HomeErrorState(error: error ?? 'Something went wrong');
    }, (List<String>? data) {
      return DogBreedListApiSuccessfulState(dogBreeds: data);
    });
  }
}
