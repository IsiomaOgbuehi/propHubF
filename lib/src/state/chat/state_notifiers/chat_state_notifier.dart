import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/domain/core/prophub_view_model.dart';
import 'package:prophub/src/domain/core/value_objects.dart';
import 'package:prophub/src/network/api_config.dart';
import 'package:prophub/src/repository/chat/chat_repository.dart';
import 'package:prophub/src/state/auth/state_notifiers/app_user_state_notifier.dart';
import 'package:prophub/src/state/chat/view_state/chat_view_state.dart';
import 'package:prophub/src/utilities/enums/chat_events.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final chatProvider = StateNotifierProvider<ChatStateNotifier, ChatViewState>((ref) => ChatStateNotifier(ref));

class ChatStateNotifier extends StateNotifier<ChatViewState> {
  final StateNotifierProviderRef ref;
  ChatStateNotifier(this.ref) : super(ChatViewState.initial());
  late IO.Socket socket;

  void getConnectedUsers() async {
    await launch(state.reference, (model) async {
      final response = await ref.read(chatRepositoryProvider).getConnectedUsers();

      state = model.emit(response.fold((left) => state.copyWith(viewState: ViewState.error, error: left), (right) {
        return state.copyWith(viewState: ViewState.success, connectedUsers: right);
      }));
    });
  }

  void getPrivateChatMessages(String connectedUserId) async {
    await launch(state.reference, (model) async {
      final response = await ref.read(chatRepositoryProvider).getPrivateChatMessages(connectedUserId);

      state = model.emit(response.fold((left) => state.copyWith(viewState: ViewState.error, error: left), (right) {
        return state.copyWith(viewState: ViewState.success, privateChatMessages: right);
      }));
    });
  }

  void initSocket() {
    socket = IO.io(ApiConfig.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.connect();

    /// ADD USER TO SOCKET
    socket.emit(ChatEvents.addUser.toEventName, ref.read(userDataProvider).userData.userId);
    socket.on(ChatEvents.addUser.toEventName, (data){
      print('Received response: $data');
    });
  }

  void sendMessage(String connectedUserId) {
    if(!state.chatMessage.isValid) return;

    /// Emit an event
    socket.emit(ChatEvents.privateMessage.toEventName, [state.chatMessage.getOrCrash(), connectedUserId]);

    /// Listen for response
    socket.on(ChatEvents.privateMessage.toEventName, (data) {
      print('Received response: $data');
    });

    chatMessageOnchange('');
  }

  void chatMessageOnchange(String input) {
    state = state.copyWith(chatMessage: ChatMessage(input));
  }
}
