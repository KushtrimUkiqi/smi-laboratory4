import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:lab4_test/dtos/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  UserBloc(): super(UserInitial()) {
    on<InitializeUserEvent>(_onUserLogIn);
    on<LogOutUserEvent>(_onUserLogOut);
  }

    void _onUserLogIn(InitializeUserEvent event, Emitter<UserState> emit){
      // emit(UserLogedIn(event.user));
    }
    void _onUserLogOut(LogOutUserEvent event, Emitter<UserState> emit){

    }

}