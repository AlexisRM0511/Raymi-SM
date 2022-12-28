part of 'search_bloc.dart';

class SearchState {
  final List<EventModel> eventModelList;
  final bool isLoading;

  SearchState({this.eventModelList = const [], this.isLoading = false});

  @override
  String toString() {
    return 'SearchState{eventModelList: $eventModelList, isLoading: $isLoading}';
  }
}
