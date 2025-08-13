import 'package:flutter/cupertino.dart';
import 'package:prophub/src/domain/core/prophub_view_model.dart';
import 'package:prophub/src/domain/core/value_failure.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/domain/utilities/option.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';
import 'package:prophub/src/state/auth/view_models/response/user_response.dart';
import 'package:prophub/src/state/chat/view_models/response/chat_message_content.dart';

import '../view_models/response/chat_group.dart';

class ChatViewState extends PropHubViewUiState<ChatViewState> {
  @override
  final PropHubExceptions error;
  @override
  final ViewState viewState;

  final List<UserResponse> connectedUsers;

  final ChatMessage chatMessage;

  final List<ChatMessageContent> privateChatMessages;

  final TextEditingController messageController;

  final GroupName groupName;

  final ViewState createGroupViewState;

  final List<ChatGroup> chatGroups;

  const ChatViewState(
      {required this.error,
      required this.viewState,
      required this.connectedUsers,
      required this.chatMessage,
      required this.privateChatMessages,
      required this.messageController,
      required this.groupName,
      required this.createGroupViewState,
      required this.chatGroups});

  factory ChatViewState.initial() => ChatViewState(
      error: const EmptyException(),
      viewState: ViewState.idle,
      connectedUsers: const [],
      chatMessage: ChatMessage(''),
      privateChatMessages: const [],
      messageController: TextEditingController(),
      groupName: GroupName(''),
      createGroupViewState: ViewState.idle,
      chatGroups: const []);

  @override
  ChatViewState copyWith({
    ViewState? viewState,
    PropHubExceptions? error,
    List<UserResponse>? connectedUsers,
    ChatMessage? chatMessage,
    List<ChatMessageContent>? privateChatMessages,
    TextEditingController? messageController,
    GroupName? groupName,
    ViewState? createGroupViewState,
    final List<ChatGroup>? chatGroups,
  }) =>
      ChatViewState(
          error: error ?? this.error,
          viewState: viewState ?? this.viewState,
          connectedUsers: connectedUsers ?? this.connectedUsers,
          chatMessage: chatMessage ?? this.chatMessage,
          privateChatMessages: privateChatMessages ?? this.privateChatMessages,
          messageController: messageController ?? this.messageController,
          groupName: groupName ?? this.groupName,
          createGroupViewState:
              createGroupViewState ?? this.createGroupViewState,
          chatGroups: chatGroups ?? this.chatGroups);

  Option<ValueFailure<dynamic>> get failureOption {
    return chatMessage.failureOrNone
        .fold(() => const None(), (value) => Some(value));
  }
}
