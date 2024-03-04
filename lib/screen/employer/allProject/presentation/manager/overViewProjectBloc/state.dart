abstract class OverViewState {}

class OverViewInitial extends OverViewState {}

class ChangeStatusState extends OverViewState {}

class ChangeLoadingStatusState extends OverViewState {}

class ChangeDateTimeLoadingState extends OverViewState {}

class ChangeDateTimeSuccessState extends OverViewState {}

class ChangeDateTimeErrorState extends OverViewState {
  final String error;
  ChangeDateTimeErrorState(this.error);
}

// Attachment
class PickFileLoadingState extends OverViewState {}

class PickFileSuccessState extends OverViewState {}

class PickFileErrorState extends OverViewState {}

class RemoveFileLoadingState extends OverViewState {}

class RemoveFileSuccessState extends OverViewState {}

class RemoveFileErrorState extends OverViewState {
  final String error;
  RemoveFileErrorState(this.error);
}
