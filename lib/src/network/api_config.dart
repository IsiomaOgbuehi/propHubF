class ApiConfig {
  static const String _baseUrl = 'https://noxa-backend-mongo.onrender.com';
  static const String socketUrl = _baseUrl;

  static const String _auth = '$_baseUrl/auth';

  static const String login = '$_auth/login';
  static const String signUp = '$_auth/signup';

  /// GET USERS YOU'VE CHATTED WITH
  static const String getConnectedUsers = '$_baseUrl/users/connected';

  /// GET ALL PRIVATE CHAT MESSAGES
  static String getPrivateChatMessages(String connectedUserId) => '$_baseUrl/private/allMessages/$connectedUserId';

  /// GROUP
  static const createGroup = '$_baseUrl/group/create';
}