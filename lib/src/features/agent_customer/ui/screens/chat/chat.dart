import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/widgets/scaffold/platform_scaffold.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: (context) => const Center(child: Icon(Icons.message_outlined, size: 70.0,)),
    );
  }
}