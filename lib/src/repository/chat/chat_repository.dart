import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prophub/src/exceptions/ground_exception.dart';
import 'package:prophub/src/network/api_config.dart';
import 'package:prophub/src/network/network_provider.dart';
import 'package:prophub/src/state/chat/view_models/request/create_group.dart';
import 'package:prophub/src/state/chat/view_models/response/chat_group.dart';
import 'package:prophub/src/state/chat/view_models/response/chat_message_content.dart';
import 'package:prophub/src/utilities/data_transformer.dart';
import '../../state/auth/view_models/response/user_response.dart';

abstract class ChatRepository {
  Future<Either<PropHubExceptions, List<UserResponse>>> getConnectedUsers();
  Future<Either<PropHubExceptions, List<ChatMessageContent>>> getPrivateChatMessages(String connectedUserId);
  Future<Either<PropHubExceptions, ChatGroup>> createChatGroup(CreateGroupRequest request);
}

final chatRepositoryProvider = Provider(
  (ref) => ChatRepositoryImpl(AppNetworkProvider(ref: ref)),
);

class ChatRepositoryImpl implements ChatRepository {
  final AppNetworkProvider _provider;
  ChatRepositoryImpl(this._provider);

  @override
  Future<Either<PropHubExceptions, List<UserResponse>>> getConnectedUsers() async {
    final response = await _provider.call(
      path: ApiConfig.getConnectedUsers,
      method: RequestMethod.get,
    );
    return await processData((p0) => (p0 as List).map((e) => UserResponse.fromJson(e)).toList(), response);
  }

  @override
  Future<Either<PropHubExceptions, List<ChatMessageContent>>> getPrivateChatMessages(String connectedUserId) async {
    final response = await _provider.call(path: ApiConfig.getPrivateChatMessages(connectedUserId), method: RequestMethod.get);
    return await processData((p0) => (p0 as List).map((e) => ChatMessageContent.fromJson(e)).toList(), response);
  }

  @override
  Future<Either<PropHubExceptions, ChatGroup>> createChatGroup(CreateGroupRequest request) async {
    final response = await _provider.call(path: ApiConfig.createGroup, method: RequestMethod.post, body: request.toJson());
    print('LOGGED RESPONSE');
    print(await response.right?.data.runtimeType);
    return await processData((p0) => ChatGroup.fromJson(p0), response);
  }
}
