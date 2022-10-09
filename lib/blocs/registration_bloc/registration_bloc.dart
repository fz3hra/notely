import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:notely/models/userModels/userModel.dart';
import 'package:notely/repository/userAuth_repository/registrationRepository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository _registrationRepository;
  RegistrationBloc(this._registrationRepository)
      : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) async {
      emit(RegistrationLoading());
      try {
        String name = event.name;
        String email = event.email;
        String password = event.password;
        final createUser =
            await _registrationRepository.createUsers(name, email, password);
        emit(RegistrationSuccess(createUser!));
      } catch (e) {
        emit(RegistrationError(error: e));
      }
    });
  }
}
