part of 'home_bloc.dart';

class HomeState {
  final List<EventModel> eventModelList;
  final String message;
  final bool isError;
  final bool isLoading;

  HomeState(
      {this.message = "No hay delitos registrados",
      this.isError = false,
      this.eventModelList = const [],
      this.isLoading = false});

  @override
  String toString() {
    return 'HomeState{eventModelList: $eventModelList, message: $message, isError: $isError, isLoading: $isLoading}';
  }
}
