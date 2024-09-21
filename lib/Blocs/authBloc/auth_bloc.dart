import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());

        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccsess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailed(errMsg: 'user-not-found'));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailed(errMsg: 'wrong-password'));
          }
        } catch (e) {
          emit(LoginFailed(errMsg: 'Something went wrong'));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFailed('The password is too weak.'));
          } else if (ex.code == 'email-already-in-use') {
            emit(RegisterFailed('The account already exists for that email.'));
          }
        } catch (ex) {
          emit(RegisterFailed('Something went wrong'));
        }
      }
    }
    );
  }
}
