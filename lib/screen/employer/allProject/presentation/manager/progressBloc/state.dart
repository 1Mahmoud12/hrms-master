abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

class AddStatusState extends ProgressState {}

// Add
class AddProgressLoadingState extends ProgressState {}

class AddProgressSuccessState extends ProgressState {}

class AddProgressErrorState extends ProgressState {}

// Edit
class EditProgressLoadingState extends ProgressState {}

class EditProgressSuccessState extends ProgressState {}

class EditProgressErrorState extends ProgressState {}

class DeleteProgressSuccessState extends ProgressState {}
