part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeScreenModel homeScreenModel;

  HomeSuccess(this.homeScreenModel);
}

class HomeError extends HomeState {}