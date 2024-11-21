import 'package:financial_manager/core/responsive/responsive_extension.dart';
import 'package:financial_manager/models/internal/status_result_model.dart';
import 'package:flutter/material.dart';

void showErrorBanner(OverlayState overlayContext, String errorMessage, StatusResult status) {
  final overlay = overlayContext;

  late final OverlayEntry overlayEntry;  

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top,  
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          color: status.isFailure ? Colors.redAccent : Colors.green,
          padding: EdgeInsets.symmetric(vertical: 12.appHeight, horizontal: 16.appWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  overlayEntry.remove(); 
                },
                child: const Text(
                  'FECHAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  if(status.doNotShow){
    return;
  }

   overlay.insert(overlayEntry);

   Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
