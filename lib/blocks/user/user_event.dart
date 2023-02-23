part of 'user_bloc.dart';

class UserEvent extends Equatable{
 const UserEvent();

 @override
  List<Object?> get props => [];
}
class InitializeUserEvent extends UserEvent {
  const InitializeUserEvent();
}

class LoginUserEvent extends UserEvent {
  final User user;

  const LoginUserEvent(this.user);
}

class LogOutUserEvent extends UserEvent {
  final User user;

  const LogOutUserEvent(this.user);
}