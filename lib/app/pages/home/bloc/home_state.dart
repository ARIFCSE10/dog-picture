part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => <Object>[];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class DogBreedListApiSuccessfulState extends HomeState {
  const DogBreedListApiSuccessfulState({required this.dogBreeds});
  final List<String>? dogBreeds;

  @override
  List<Object?> get props => <Object?>[dogBreeds];
}

class HomeErrorState extends HomeState {
  const HomeErrorState({required this.error});
  final String error;

  @override
  List<Object> get props => <Object>[error];
}
