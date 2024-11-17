enum ChatEvents {
  connection('connection'),
  addUser('addUser'),
  privateMessage('privateMessage');

  final String toEventName;
  const ChatEvents(this.toEventName);
}