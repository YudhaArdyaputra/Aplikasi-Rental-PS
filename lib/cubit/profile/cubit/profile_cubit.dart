import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitialState());

  void setProfile(String roles, int iduser){
    emit(ProfileState(roles: roles, iduser: iduser));
  }
}