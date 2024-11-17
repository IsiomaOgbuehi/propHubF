import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:prophub/src/state/chat/state_notifiers/chat_state_notifier.dart';
import 'package:prophub/src/widgets/scaffold/platform_scaffold.dart';
import 'package:prophub/src/widgets/text_input/ProphubTextfield.dart';

import '../widgets/message_box.dart';

class MessageScreen extends ConsumerStatefulWidget {
  final String connectedUserId;
  const MessageScreen({super.key, required this.connectedUserId});

  @override
  ConsumerState createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ref.read(chatProvider.notifier).getPrivateChatMessages(widget.connectedUserId);
      ref.read(chatProvider.notifier).initSocket();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        backgroundColor: Colors.white24.withOpacity(0.9),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0.5,
          title: const Text('Messages'),
        ),
        body: (context) => SafeArea(
              child: Column(
                children: [
                  const Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      MessageBox(
                        sentMessage: true,
                        message: 'Recharge the leave power',
                      ),
                      MessageBox(
                        sentMessage: false,
                        message: 'Taken in the bar of business',
                      ),
                    ],
                  ))),
                  Row(
                    children: [
                      Expanded(
                        child: PropHubBackgroundTextField(
                          controller: ref.watch(chatProvider).messageController,
                          title: 'Message',
                          background: Colors.grey.withOpacity(0.2),
                          inputRadius: 50.0,
                          onChanged: ref.watch(chatProvider.notifier).chatMessageOnchange,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      OutlinedButton(
                          onPressed: () => ref.read(chatProvider.notifier).sendMessage(widget.connectedUserId),
                          child: Icon(
                            Iconsax.send_1,
                            size: 30.0,
                            color: ref.watch(chatProvider).chatMessage.isValid ? Colors.lightGreen : Colors.black38,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  )
                ],
              ),
            ));
  }
}
