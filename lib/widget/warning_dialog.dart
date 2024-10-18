import 'package:flutter/material.dart';

class Consts {
  Consts._();
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class WarningDialog extends StatelessWidget {
  final String description; // Make description non-nullable
  final VoidCallback? okClick;

  const WarningDialog({Key? key, required this.description, this.okClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: Consts.padding,
        bottom: Consts.padding,
        left: Consts.padding,
        right: Consts.padding,
      ),
      margin: const EdgeInsets.only(top: Consts.avatarRadius),
      decoration: BoxDecoration(
        color: Colors.red[50], // Light red background
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Consts.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.red[200]!, // Light red shadow
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "WARNING",
            style: TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.red),
          ),
          const SizedBox(height: 16.0),
          Text(
            description, // No need for null assertion
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.red, // Red text
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                okClick?.call(); // Use null-aware operator
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red), // Red border
              ),
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.red), // Red text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
