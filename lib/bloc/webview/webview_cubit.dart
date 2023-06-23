// Cubit to manage the loading state of the webview
import 'package:flutter_bloc/flutter_bloc.dart';

// Event to represent the loading state of the webview
abstract class WebViewEvent {}

class WebViewStarted extends WebViewEvent {}

class WebViewFinished extends WebViewEvent {}

class WebViewCubit extends Cubit<bool> {
  WebViewCubit() : super(true);

  void startLoading() => emit(true);

  void finishLoading() => emit(false);

  void handleEvent(WebViewEvent event) {
    if (event is WebViewStarted) {
      startLoading();
    } else if (event is WebViewFinished) {
      finishLoading();
    }
  }
}
