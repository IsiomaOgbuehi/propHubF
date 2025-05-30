class CreateGroupRequest {
  final String groupName;

  const CreateGroupRequest({required this.groupName});

  Map<String, dynamic> toJson() => {'name': groupName};
}