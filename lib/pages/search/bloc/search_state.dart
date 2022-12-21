part of 'search_bloc.dart';

class SearchState {
  final List<EventModel> eventModelList;
  final String message;
  final bool isError;
  final bool isLoading;

  SearchState(
      {this.message = "Escriba el título del delito a buscar",
      this.isError = false,
      this.eventModelList = const [],
      this.isLoading = false});

  @override
  String toString() {
    return 'SearchState{eventModelList: $eventModelList, message: $message, isError: $isError, isLoading: $isLoading}';
  }
}
