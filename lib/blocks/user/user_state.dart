part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLogedIn extends UserState {
  final User user;

  const UserLogedIn(this.user);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}