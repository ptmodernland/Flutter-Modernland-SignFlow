class BroadcastMessageResponseDto {
  BroadcastMessageResponseDto({
    bool? status,
    List<Announcements>? announcements,
  }) {
    _status = status;
    _announcements = announcements;
  }

  BroadcastMessageResponseDto.fromJson(dynamic json) {
    _status = json['status'];
    if (json['announcements'] != null) {
      _announcements = [];
      json['announcements'].forEach((v) {
        _announcements?.add(Announcements.fromJson(v));
      });
    }
  }

  bool? _status;
  List<Announcements>? _announcements;

  BroadcastMessageResponseDto copyWith({
    bool? status,
    List<Announcements>? announcements,
  }) =>
      BroadcastMessageResponseDto(
        status: status ?? _status,
        announcements: announcements ?? _announcements,
      );

  bool? get status => _status;

  List<Announcements>? get announcements => _announcements;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_announcements != null) {
      map['announcements'] = _announcements?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Announcements {
  Announcements({
    String? messageId,
    String? senderUsername,
    String? department,
    String? messageText,
    dynamic imagePath,
    String? sentTimestamp,
    dynamic directLink,
  }) {
    _messageId = messageId;
    _senderUsername = senderUsername;
    _department = department;
    _messageText = messageText;
    _imagePath = imagePath;
    _sentTimestamp = sentTimestamp;
    _directLink = directLink;
  }

  Announcements.fromJson(dynamic json) {
    _messageId = json['message_id'];
    _senderUsername = json['sender_username'];
    _department = json['department'];
    _messageText = json['message_text'];
    _imagePath = json['image_path'];
    _sentTimestamp = json['sent_timestamp'];
    _directLink = json['direct_link'];
  }

  String? _messageId;
  String? _senderUsername;
  String? _department;
  String? _messageText;
  dynamic _imagePath;
  String? _sentTimestamp;
  dynamic _directLink;

  Announcements copyWith({
    String? messageId,
    String? senderUsername,
    String? department,
    String? messageText,
    dynamic imagePath,
    String? sentTimestamp,
    dynamic directLink,
  }) =>
      Announcements(
        messageId: messageId ?? _messageId,
        senderUsername: senderUsername ?? _senderUsername,
        department: department ?? _department,
        messageText: messageText ?? _messageText,
        imagePath: imagePath ?? _imagePath,
        sentTimestamp: sentTimestamp ?? _sentTimestamp,
        directLink: directLink ?? _directLink,
      );

  String? get messageId => _messageId;

  String? get senderUsername => _senderUsername;

  String? get department => _department;

  String? get messageText => _messageText;

  dynamic get imagePath => _imagePath;

  String? get sentTimestamp => _sentTimestamp;

  String? get directLink => _directLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message_id'] = _messageId;
    map['sender_username'] = _senderUsername;
    map['department'] = _department;
    map['message_text'] = _messageText;
    map['image_path'] = _imagePath;
    map['sent_timestamp'] = _sentTimestamp;
    map['direct_link'] = _directLink;
    return map;
  }
}
