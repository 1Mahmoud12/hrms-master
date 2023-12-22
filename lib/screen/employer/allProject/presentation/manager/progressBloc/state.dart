abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

// Attachment
class AddProgressLoadingState extends ProgressState {}

class AddProgressSuccessState extends ProgressState {}

class AddProgressErrorState extends ProgressState {}
