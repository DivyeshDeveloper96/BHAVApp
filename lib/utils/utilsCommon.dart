import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/themes/colorConstants.dart';

class UtilsCommon {
  static DateTime parseDateTime(String dateString, {bool addDays = false}) {
    DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateString);
    if (addDays) {
      parsedDate = parsedDate.add(const Duration(days: 30));
    }
    return parsedDate;
  }

  static String formatDateTime(
    String format,
    DateTime dateTime,
    String locale,
  ) {
    String formattedDateTime =
        DateFormat.MMMEd(
          locale == "" ? "en" : locale,
        ).format(dateTime).toString();
    return formattedDateTime;
  }

  static String formatDate(String dateString, {bool addDays = false}) {
    try {
      /*DateTime parsedDate =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ").parse(dateString);*/
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateString);
      if (addDays) {
        parsedDate = parsedDate.add(const Duration(days: 30));
      }
      String formattedDate = DateFormat("dd MMM yyyy").format(parsedDate);
      return formattedDate;
    } catch (e) {
      return dateString;
    }
  }

  static String formatDateAs(String dateString, String format) {
    try {
      if (dateString.isNotEmpty) {
        DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateString);
        String formattedDate = DateFormat(format).format(parsedDate);
        return formattedDate;
      } else {
        return "--";
      }
    } catch (e) {
      return dateString;
    }
  }

  static String formatDatewithAnyPattern(
    String dateString,
    String outputFormat,
  ) {
    if (dateString.isEmpty) return "NA";

    List<String> inputFormats = [
      // ISO
      'yyyy-MM-dd',
      'yyyy-MM-ddTHH:mm:ss',
      'yyyy-MM-ddTHH:mm:ssZ',
      'yyyy-MM-ddTHH:mm:ss.SSSZ',
      'yyyy-MM-dd HH:mm:ss',

      // Indian formats
      'dd-MM-yyyy',
      'dd/MM/yyyy',
      'dd.MM.yyyy',
      'dd MMM yyyy',
      'dd MMMM yyyy',
      'dd-MM-yyyy HH:mm:ss',
      'dd/MM/yyyy HH:mm:ss',

      // US formats
      'MM-dd-yyyy',
      'MM/dd/yyyy',
      'MM.dd.yyyy',
      'MM-dd-yyyy HH:mm:ss',
      'MM/dd/yyyy HH:mm:ss',

      // European formats
      'dd.MM.yyyy',
      'dd.MM.yyyy HH:mm:ss',

      // Text formats
      'MMMM dd, yyyy',
      'MMM dd, yyyy',
      'EEE, dd MMM yyyy',
      'EEE, dd MMMM yyyy',

      // Compact numeric formats
      'yyyyMMdd',
      'ddMMyyyy',
      'MMddyyyy',

      // Date & Time variations
      'yyyy-MM-dd HH:mm',
      'dd-MM-yyyy HH:mm',
      'MM/dd/yyyy hh:mm a',
      'dd/MM/yyyy hh:mm a',
      'MMM dd, yyyy hh:mm a',
      'MMMM dd, yyyy hh:mm a',

      // UTC variants
      'yyyy-MM-ddTHH:mm:ss.SSS',
      'yyyy-MM-ddTHH:mm:ss.SSSZ',
      'yyyy-MM-ddTHH:mm:ss.SSS+0000',
      'yyyy-MM-ddTHH:mm:ssZ',
    ];

    for (String format in inputFormats) {
      try {
        DateTime parsedDate = DateFormat(format).parseStrict(dateString);
        return DateFormat(outputFormat).format(parsedDate);
      } catch (_) {}
    }

    // Fallback for ISO8601
    try {
      DateTime? parsed = DateTime.tryParse(dateString);
      if (parsed != null) {
        return DateFormat(outputFormat).format(parsed);
      }
    } catch (_) {}

    return dateString;
  }

  static String formatDatewithPattern(
    String dateString,
    String outputformat,
    String inputformat,
  ) {
    try {
      if (dateString.isNotEmpty) {
        DateTime parsedDate = DateFormat(inputformat).parse(dateString);
        String formattedDate = DateFormat(outputformat).format(parsedDate);
        return formattedDate;
      } else {
        return "--";
      }
    } catch (e) {
      return dateString;
    }
  }

  static int getSelectedItemCount(RxString selectedValue) {
    return selectedValue.value
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .length;
  }

  /*static customToast(BuildContext context, String message,
      {bool isCenter = false}) {
    ToastContext().init(context);

    Toast.show(message,
        duration: 4,
        gravity: isCenter ? Toast.center : Toast.bottom,
        textStyle: TextStyle(fontSize: 15, color: Colors.white));
  }*/

  static void showCustomSnackBar(
    BuildContext context, {
    required bool isSuccess,
    required String message,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: duration,
        backgroundColor: isSuccess ? Colors.green : Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            /*Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            const SizedBox(width: 12),*/
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        action:
            (actionLabel != null && onAction != null)
                ? SnackBarAction(
                  label: actionLabel,
                  textColor: Colors.white,
                  onPressed: onAction,
                )
                : null,
      ),
    );
  }

  static showSnackbarOnSuccessnFail(String? msg, bool isSuccess) {
    final message = msg ?? "";
    if (message.trim().isEmpty) return;

    showToastSnackbar(
      title: isSuccess ? "Success" : "Alert",
      msg: message,
      type: isSuccess ? ToastType.success : ToastType.error,
    );
  }

  static showToastSnackbar({
    required String title,
    String msg = "",
    ToastType type = ToastType.success,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    final message = msg.trim();
    if (message.isEmpty || message == "Access denied.") {
      return;
    }
    Get.closeCurrentSnackbar();
    Get.snackbar(
      title,
      message,
      colorText: type.toastTextColor,
      snackPosition: position,
      backgroundColor: type.toastColor,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 8,
    );
  }
}

enum ToastType {
  success,
  error,
  warning,
  info;

  Color get toastColor {
    switch (this) {
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.orange;
      case ToastType.warning:
        return Colors.orange;
      case ToastType.info:
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  //text color
  Color get toastTextColor {
    switch (this) {
      case ToastType.success:
        return Colors.white;
      default:
        return Colors.white;
    }
  }
}
