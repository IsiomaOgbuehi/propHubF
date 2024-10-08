import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:prophub/src/widgets/scaffold/platform_scaffold.dart';
import 'package:prophub/src/widgets/text_input/ProphubTextfield.dart';

import '../widgets/message_box.dart';

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({super.key});

  @override
  ConsumerState createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  final searchController = TextEditingController();

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
                  Expanded(
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
                  Column(
                    children: [
                      PropHubBackgroundTextField(
                        controller: searchController,
                        title: 'Search',
                        background: Colors.grey.withOpacity(0.2),
                        inputRadius: 50.0,
                        suffix: Icon(Iconsax.send_1, size: 30.0,),
                      ),
                      const SizedBox(
                        height: 5.0,
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}
