import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:prophub/src/state/auth/state_notifiers/app_user_state_notifier.dart';
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
  final ScrollController _controller = ScrollController();
  int initialScroll = 0;

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    initialScroll = 1;
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      ref.read(chatProvider.notifier).getPrivateChatMessages(widget.connectedUserId, _scrollDown);
      ref.read(chatProvider.notifier).initSocket();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chatProvider.select((value) => value.privateChatMessages), (previous, next) {
      if(previous!.isNotEmpty && initialScroll == 0) {
        _scrollDown();
      }
    });
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
                  Expanded(
                      child: ListView.builder(
                          controller: _controller,
                          itemCount: ref.watch(chatProvider).privateChatMessages.length,
                          itemBuilder: (context, index) {
                            final chatItem = ref.watch(chatProvider).privateChatMessages;
                            return MessageBox(
                              sentMessage: chatItem[index].senderId == ref.read(userDataProvider).userData.userId,
                              message: chatItem[index].content,
                              chatDate: chatItem[index].createdAt,
                            );
                          })),
                  const SizedBox(
                    height: 10.0,
                  ),
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
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size.zero, // Set this
                            padding: EdgeInsets.zero,
                            side: const BorderSide(
                              color: Colors.transparent,
                            ), // and this
                          ),
                          child: Icon(
                            Iconsax.send_1,
                            size: 40.0,
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
