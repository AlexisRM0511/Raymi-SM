part of 'home_bloc.dart';

class HomeState {
  final List<SueModel> sueModelList;
  final String message;
  final bool isError;
  final bool isLoading;

  HomeState(
      {this.message = "No hay delitos registrados",
      this.isError = false,
      this.sueModelList = const [],
      this.isLoading = false});

  @override
  String toString() {
    return 'HomeState{sueModelList: $sueModelList, message: $message, isError: $isError, isLoading: $isLoading}';
  }
}
