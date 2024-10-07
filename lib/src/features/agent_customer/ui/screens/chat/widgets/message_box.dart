import 'package:flutter/material.dart';
import 'package:prophub/src/theme/app_text_styles.dart';

class MessageBox extends StatelessWidget {
  final bool sentMessage;
  final String message;
  const MessageBox({super.key, required this.sentMessage, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: sentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15.0),
    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.3,),
          padding: const EdgeInsets.all(10.0),
          // width: MediaQuery.of(context).size.width / 1.3,
          decoration: BoxDecoration(
            color: sentMessage ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Text(message, style: AppTextStyles.body2Regular.copyWith(color: sentMessage ? Colors.white : Colors.black),),
        )
      ],
    );
  }
}