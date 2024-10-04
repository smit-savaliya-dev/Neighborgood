import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoadingProvider with ChangeNotifier {
  final BuildContext? context;
  LoadingProvider({required this.context});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void showLoader() {
    context?.loaderOverlay.show();
    _isLoading = true;
    notifyListeners();
  }

  void hideLoader() {
    context?.loaderOverlay.hide();
    _isLoading = false;
    notifyListeners();
  }
}
