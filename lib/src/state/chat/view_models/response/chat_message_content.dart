class ChatMessageContent {
  final String chatId;
  final String senderId;
  final String receiverId;
  final String content;
  final String createdAt;

  const ChatMessageContent(
      {required this.chatId,
      required this.senderId,
      required this.receiverId,
      required this.content,
      required this.createdAt});

  factory ChatMessageContent.fromJson(Map<String, dynamic> json) => ChatMessageContent(
      chatId: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      createdAt: json['createdAt']);
}
