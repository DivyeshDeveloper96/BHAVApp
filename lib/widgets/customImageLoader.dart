import 'package:flutter/material.dart';

class CustomImageLoader extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  const CustomImageLoader({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.backgroundColor,
  }) : super(key: key);

  Widget _defaultPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius,
      ),
      child: Center(child: Image.asset("assets/images/placeholder.png")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final placeholderWidget = placeholder ?? _defaultPlaceholder(context);
    final errWidget = errorWidget ?? placeholderWidget;

    // If url is null or empty, show placeholder immediately.
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: placeholderWidget,
      );
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        // Show placeholder while loading
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholderWidget;
        },
        // Show error widget if any error occurs
        errorBuilder: (context, error, stackTrace) {
          return errWidget;
        },
      ),
    );
  }
}
