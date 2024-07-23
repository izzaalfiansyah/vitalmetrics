abstract class AppState {
  bool isLoading;
  bool isError;
  String? message;

  AppState({
    this.isLoading = false,
    this.isError = false,
    this.message,
  });
}
