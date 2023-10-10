import 'package:flutter/material.dart';
import 'package:video_to_audio/core/presentation/widgets/spacers/horizontal_spacers.dart';

class CustomErrorMessage extends StatefulWidget {
  final String message;
  const CustomErrorMessage({Key? key, required this.message}) : super(key: key);

  @override
  State<CustomErrorMessage> createState() => _CustomErrorMessageState();
}

class _CustomErrorMessageState extends State<CustomErrorMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HorizontalSpacer8(),
        Text(
          widget.message,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
