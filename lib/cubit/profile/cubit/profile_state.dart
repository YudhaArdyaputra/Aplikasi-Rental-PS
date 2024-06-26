part of 'profile_cubit.dart';

@immutable
class ProfileState {
  final String roles;
  final int iduser;

  const ProfileState({required this.roles, required this.iduser});
}

final class ProfileInitialState extends ProfileState {
  const ProfileInitialState() : super(roles: 'umum', iduser: 0);
}