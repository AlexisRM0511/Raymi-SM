part of 'search_bloc.dart';

class SearchState {
  final List<SueModel> sueModelList;
  final String message;
  final bool isError;
  final bool isLoading;

  SearchState(
      {this.message = "Escriba el título del delito a buscar",
      this.isError = false,
      this.sueModelList = const [],
      this.isLoading = false});

  @override
  String toString() {
    return 'SearchState{sueModelList: $sueModelList, message: $message, isError: $isError, isLoading: $isLoading}';
  }
}
