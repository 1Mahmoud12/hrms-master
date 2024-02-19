abstract class MainBlocMaintenanceContractState {}

class MainBlocMaintenanceContractInitial extends MainBlocMaintenanceContractState {}

class SelectLocationState extends MainBlocMaintenanceContractState {}

class ChangeIndexState extends MainBlocMaintenanceContractState {}

class ChangeCheckBoxState extends MainBlocMaintenanceContractState {}


class AddPeriodicLoadingState extends MainBlocMaintenanceContractState {}
class AddPeriodicSuccessState extends MainBlocMaintenanceContractState {}
class AddPeriodicErrorState extends MainBlocMaintenanceContractState {
  final String error;
  AddPeriodicErrorState(this.error);
}
