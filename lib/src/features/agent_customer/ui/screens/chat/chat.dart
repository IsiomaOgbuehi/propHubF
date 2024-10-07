import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/chat/views/messages.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/utilities/navigation/navigator.dart';
import 'package:prophub/src/widgets/list_tile/PropHubListTile.dart';
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
      appBar: AppBar(
        shadowColor: Colors.grey,
        elevation: 0.5,
        title: const Text('Community'),
          automaticallyImplyLeading: false,
        actions: [
          PreferredSize(
              preferredSize: const Size.fromHeight(56),
          child: Padding(padding: EdgeInsets.only(right: Constants.scaffoldHorizontalPadding,),
            child: PopupMenuButton(
                offset: const Offset(0, 45),
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'add_group',
                    child: ListTile(
                      leading: Icon(Icons.add_circle_outline_sharp),
                      title: Text('Add Group'),
                      onTap: () {},
                    ),
                  ),
                ]
            )
          //   InkWell(
          //     onTap: _showOptionsDialog,
          //   child: Icon(Icons.more_vert),
          // ),
          )
          )
        ],
      ),
      body: (context) => Column(
        children: [
          PropHubListTile(
            onTap: () => context.push(MessageScreen()),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(width: 1.0)
              ),
              child: Center(
                child: Text('JD', style: AppTextStyles.body2Medium.copyWith(color: Colors.white),),
              )
            ),
            title: Text('John Doe'),
          )
        ],
      ),
    );
  }

  void _showOptionsDialog() {
     showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Create Group'),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      );
  }
}