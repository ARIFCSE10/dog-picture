part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => <Object>[];
}

class DogBreedListDataInitLoadEvent extends HomeEvent {
  const DogBreedListDataInitLoadEvent();

  @override
  List<Object> get props => <Object>[];
}
