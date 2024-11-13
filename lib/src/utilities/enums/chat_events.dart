enum ChatEvents {
  addUser('addUser'),
  privateMessage('privateMessage');

  final String toEventName;
  const ChatEvents(this.toEventName);
}