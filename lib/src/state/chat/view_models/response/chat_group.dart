class ChatGroup {
  final String groupName;
  final String ownerId;
  final List<String> members;
  final String createdAt;

  const ChatGroup({required this.groupName, required this.ownerId, required this.members, required this.createdAt});

  factory ChatGroup.fromJson(Map<String, dynamic> json) => ChatGroup(
      groupName: json['name'], ownerId: json['ownerId'], members: json['members'] ?? [], createdAt: json['createdAt']);
}
