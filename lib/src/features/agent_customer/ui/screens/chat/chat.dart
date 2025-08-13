import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:prophub/src/features/agent_customer/ui/screens/chat/views/messages.dart';
import 'package:prophub/src/state/chat/state_notifiers/chat_state_notifier.dart';
import 'package:prophub/src/theme/app_text_styles.dart';
import 'package:prophub/src/utilities/constants/app_constants.dart';
import 'package:prophub/src/utilities/navigation/navigator.dart';
import 'package:prophub/src/widgets/list_tile/PropHubListTile.dart';
import 'package:prophub/src/widgets/scaffold/platform_scaffold.dart';

import '../../../../../domain/core/prophub_view_model.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../widgets/bottons/app_buttons.dart';
import '../../../../../widgets/text_input/ProphubTextfield.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _groupName = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) async {
      ref.read(chatProvider.notifier).getConnectedUsers();
    });
  }

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
                child: Padding(
                    padding: EdgeInsets.only(
                      right: Constants.scaffoldHorizontalPadding,
                    ),
                    child: PopupMenuButton(
                        offset: const Offset(0, 45),
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                value: 'add_group',
                                child: ListTile(
                                  leading: const Icon(
                                      Icons.add_circle_outline_sharp),
                                  title: const Text('Create Group'),
                                  onTap: () {
                                    context.pop();
                                    _createGroupSheet();
                                  },
                                ),
                              ),
                            ])
                    //   InkWell(
                    //     onTap: _showOptionsDialog,
                    //   child: Icon(Icons.more_vert),
                    // ),
                    ))
          ],
        ),
        body: (context) => RefreshIndicator(
            onRefresh: () async => await Future.microtask(
                ref.read(chatProvider.notifier).getConnectedUsers),
            child: ref.watch(chatProvider).connectedUsers.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      final user =
                          ref.watch(chatProvider).connectedUsers[index];
                      return PropHubListTile(
                        onTap: () => context.push(MessageScreen(
                          connectedUserId: user.userId,
                        )),
                        leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius: BorderRadius.circular(50.0),
                                border: Border.all(width: 1.0)),
                            child: Center(
                              child: Text(
                                '${user.firstname.substring(0, 1)}${user.lastname.substring(0, 1)}',
                                style: AppTextStyles.body2Medium
                                    .copyWith(color: Colors.white),
                              ),
                            )),
                        title: Text('${user.firstname} ${user.lastname}'),
                      );
                    },
                    itemCount: ref.watch(chatProvider).connectedUsers.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      thickness: 1.0,
                      color: Colors.black12,
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) => ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 15.0),
                      children: [
                        Container(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: ref.watch(chatProvider).viewState ==
                                    ViewState.loading
                                ? Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : Center(
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      height: 200,
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Iconsax.user_minus_copy,
                                            size: 150,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('No User Found')
                                        ],
                                      ),
                                    ),
                                  ))
                      ],
                    ),
                  )));
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

  void _createGroupSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.mercuryGrey,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (dialogContext) {
        return Container(
            decoration: const BoxDecoration(
              color: AppColors.neutral00,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    Constants.borderRadius,
                  ),
                  topRight: Radius.circular(Constants.borderRadius)),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 27),
            child: Consumer(
              builder: (context, ref, _) {
                return Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Iconsax.close_circle,
                            size: 30.0,
                            color: AppColors.neutral04,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Create New Group',
                      style: AppTextStyles.body1SemiBold,
                    ),
                    SizedBox(height: 18.h),
                    PropHubBackgroundTextField(
                      background: AppColors.neutral03,
                      controller: _groupName,
                      title: 'Group Name',
                      onChanged:
                          ref.watch(chatProvider.notifier).groupNameOnchange,
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        Flexible(
                            child: IgnorePointer(
                          ignoring:
                              ref.watch(chatProvider).createGroupViewState ==
                                  ViewState.loading,
                          child: PropFlatButton(
                            buttonColor: Colors.blueGrey,
                            textColor: Colors.white,
                            onTap: () {
                              ref.read(chatProvider.notifier).createGroup(resetState);
                              _groupName.text = '';
                            },
                            title: 'Create Group',
                            isDisabled: ValueNotifier(
                                !ref.watch(chatProvider).groupName.isValid),
                            isLoading: ValueNotifier(
                                ref.watch(chatProvider).createGroupViewState ==
                                    ViewState.loading),
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    const _GroupCreationStatus()
                  ],
                );
              },
            ));
      },
    );
  }
  void resetState() {
    setState(() {

    });
  }
}

class _GroupCreationStatus extends ConsumerWidget {
  const _GroupCreationStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(chatProvider).createGroupViewState;

    if (viewState == ViewState.success) {
      return Text(
        'Group Created!',
        style: AppTextStyles.body2Regular.copyWith(color: AppColors.green2),
      );
    }

    return const SizedBox.shrink();
  }
}
