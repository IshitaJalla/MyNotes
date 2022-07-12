import 'package:bloc/bloc.dart';
import 'package:learningdart/services/auth/auth_provider.dart';
import 'package:learningdart/services/auth/bloc/auth_event.dart';
import 'package:learningdart/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {
    //initialise
    on<AuthEventInitialise>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ),
        );
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerfication());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    //send Email Verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    //REGISTER
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerfication());
      } on Exception catch (e) {
        emit(AuthStateRegistering(e));
      }
    });

    //logIn
    on<AuthEventLogIn>((event, emit) async {
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
        ),
      );
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );

        if (!user.isEmailVerified) {
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(const AuthStateNeedsVerfication());
        } else {
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
          emit(AuthStateLoggedIn(user));
        }
      } on Exception catch (e) {
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });

    //logOut
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(const AuthStateUninitialized());
        //indicating to the outside world that we are doing something
        await provider.logOut();
        emit(
          const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ),
        );
      } on Exception catch (e) {
        emit(
          AuthStateLoggedOut(
            exception: e,
            isLoading: false,
          ),
        );
      }
    });
  }
}
