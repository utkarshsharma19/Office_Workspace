part of 'edit_view_bloc.dart';

@immutable
abstract class EditViewState {}

class EditViewInitial extends EditViewState {}

class EditViewLoaded extends EditViewState{}

class EditState extends EditViewState{}

class ViewState extends EditViewState{}

class EditViewError extends EditViewState{}
