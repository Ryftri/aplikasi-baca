import 'package:flutter/material.dart';

class WidgetMessage extends StatefulWidget {
  final String message;
  const WidgetMessage({
    super.key,
    required this.message,
  });

  @override
  State<WidgetMessage> createState() => _WidgetMessageState();
}

class _WidgetMessageState extends State<WidgetMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 7.0,
      ),
      child: Center(
        child: Text(
          widget.message,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
      ),
    );
  }
}