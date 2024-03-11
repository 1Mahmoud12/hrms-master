abstract class TasksState {}

class TasksInitial extends TasksState {}

class AddStatusState extends TasksState {}

// Add
class AddTasksLoadingState extends TasksState {}

class AddTasksSuccessState extends TasksState {}

class AddTasksErrorState extends TasksState {}

// Edit
class EditTasksLoadingState extends TasksState {}

class EditTasksSuccessState extends TasksState {}

class EditTasksErrorState extends TasksState {}

class DeleteTasksSuccessState extends TasksState {}

class DeleteTasksLoadingState extends TasksState {}

class DeleteTasksErrorState extends TasksState {}
