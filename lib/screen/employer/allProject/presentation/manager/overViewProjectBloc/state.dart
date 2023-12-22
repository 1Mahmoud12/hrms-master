abstract class OverViewState {}

class OverViewInitial extends OverViewState {}

class ChangeStatusState extends OverViewState {}

class ChangeDateTimeState extends OverViewState {}

// Attachment
class PickFileLoadingState extends OverViewState {}

class PickFileSuccessState extends OverViewState {}

class PickFileErrorState extends OverViewState {}
