import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/domain/core/prophub_view_model.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/network/api_config.dart';
import 'package:prophub/src/repository/chat/chat_repository.dart';
import 'package:prophub/src/state/auth/state_notifiers/app_user_state_notifier.dart';
import 'package:prophub/src/state/chat/view_models/response/chat_message_content.dart';
import 'package:prophub/src/state/chat/view_state/chat_view_state.dart';
import 'package:prophub/src/utilities/enums/chat_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../view_models/request/create_group.dart';

final chatProvider = StateNotifierProvider<ChatStateNotifier, ChatViewState>(
    (ref) => ChatStateNotifier(ref));

class ChatStateNotifier extends StateNotifier<ChatViewState> {
  final Ref ref;
  ChatStateNotifier(this.ref) : super(ChatViewState.initial());
  late IO.Socket socket;
  bool isSocketInitialized = false;

  @override
  void dispose() {
    super.dispose();
    state.messageController.dispose();
    socket.disconnect();
    socket.off(ChatEvents.privateMessage.toEventName);
  }

  void getConnectedUsers() async {
    await launch(state.reference, (model) async {
      state = state.copyWith(viewState: ViewState.loading);
      final response =
          await ref.read(chatRepositoryProvider).getConnectedUsers();

      state = model.emit(response.fold(
          (left) => state.copyWith(viewState: ViewState.error, error: left),
          (right) {
        return state.copyWith(
            viewState: ViewState.success, connectedUsers: right);
      }));
    });
  }

  void getPrivateChatMessages(String connectedUserId,
      [Function? callBack]) async {
    await launch(state.reference, (model) async {
      final response = await ref
          .read(chatRepositoryProvider)
          .getPrivateChatMessages(connectedUserId);

      state = model.emit(response.fold(
          (left) => state.copyWith(viewState: ViewState.error, error: left),
          (right) {
        return state.copyWith(
            viewState: ViewState.success, privateChatMessages: right);
      }));
      Future.delayed(const Duration(seconds: 2), () {
        callBack?.call();
      });
    });
  }

  void initSocket() {
    if (isSocketInitialized) return;
    isSocketInitialized = true;

    socket = IO.io(
        ApiConfig.socketUrl,
        IO.OptionBuilder().setTransports(['websocket']) // optional
            .build());

    socket.connect();

    /// ADD USER TO SOCKET
    socket.emit(ChatEvents.addUser.toEventName,
        ref.read(userDataProvider).userData.userId);

    /// Listen for response
    listenToPrivateMessages();
  }

  void sendMessage(String connectedUserId) {
    if (!state.chatMessage.isValid || connectedUserId.isEmpty) return;

    /// Emit an event
    socket.emit(ChatEvents.privateMessage.toEventName, [
      state.chatMessage.getOrCrash(),
      connectedUserId,
      ref.read(userDataProvider).userData.userId
    ]);

    state = state.copyWith(messageController: TextEditingController());
    chatMessageOnchange('');
  }

  void chatMessageOnchange(String input) {
    state = state.copyWith(chatMessage: ChatMessage(input));
  }

  void groupNameOnchange(String input) {
    state = state.copyWith(groupName: GroupName(input));
  }

  void listenToPrivateMessages() {
    socket.off(
        ChatEvents.privateMessage.toEventName); // Prevent duplicate listeners
    socket.on(ChatEvents.privateMessage.toEventName, (data) {
      final chatData = ChatMessageContent.fromJson(data);
      state = state.copyWith(
          privateChatMessages:
              {...state.privateChatMessages, chatData}.toList());
    });
  }

  void createGroup(Function callBack) async {
    await launch(state.reference, (model) async {
      state = state.copyWith(createGroupViewState: ViewState.loading);

      final response = await ref.read(chatRepositoryProvider).createChatGroup(
          CreateGroupRequest(groupName: state.groupName.getOrCrash()));
      print('PROCEEDINGS......');

      if(response.isRight) {
        print('CALLING CALLBACK');
        callBack.call();
      }

      if(response.isLeft) {
        print(response.left.message);
        print(response.left);
        print('CALLING CALLBACK LEFT');
        callBack.call();
        state = state.copyWith(createGroupViewState: ViewState.error);
      }

      state = model.emit(response.fold(
          (left) => state.copyWith(
              createGroupViewState: ViewState.error, error: left), (right) {
        return state.copyWith(
            createGroupViewState: ViewState.success,
            chatGroups: [...state.chatGroups, right], groupName: GroupName(''));
      }));
    });
  }
}
