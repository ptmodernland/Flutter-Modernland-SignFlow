class StreamPagingDto {
  StreamPagingDto({
    String? message,
    SnipWrapper? data,
  }) {
    _message = message;
    _data = data;
  }

  StreamPagingDto.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? SnipWrapper.fromJson(json['data']) : null;
  }

  String? _message;
  SnipWrapper? _data;

  StreamPagingDto copyWith({
    String? message,
    SnipWrapper? data,
  }) =>
      StreamPagingDto(
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get message => _message;

  SnipWrapper? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class SnipWrapper {
  SnipWrapper({
    List<StreamData>? stream,
    Pagination? pagination,
  }) {
    _stream = stream;
    _pagination = pagination;
  }

  SnipWrapper.fromJson(dynamic json) {
    if (json['stream'] != null) {
      _stream = [];
      json['stream'].forEach((v) {
        _stream?.add(StreamData.fromJson(v));
      });
    }
    _pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  List<StreamData>? _stream;
  Pagination? _pagination;

  SnipWrapper copyWith({
    List<StreamData>? stream,
    Pagination? pagination,
  }) =>
      SnipWrapper(
        stream: stream ?? _stream,
        pagination: pagination ?? _pagination,
      );

  List<StreamData>? get stream => _stream;

  Pagination? get pagination => _pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_stream != null) {
      map['stream'] = _stream?.map((v) => v.toJson()).toList();
    }
    if (_pagination != null) {
      map['pagination'] = _pagination?.toJson();
    }
    return map;
  }
}

class Pagination {
  Pagination({
    bool? isLastPage,
    num? nextCursor,
    num? total,
  }) {
    _isLastPage = isLastPage;
    _nextCursor = nextCursor;
    _total = total;
  }

  Pagination.fromJson(dynamic json) {
    _isLastPage = json['is_last_page'];
    _nextCursor = json['next_cursor'];
    _total = json['total'];
  }

  bool? _isLastPage;
  num? _nextCursor;
  num? _total;

  Pagination copyWith({
    bool? isLastPage,
    num? nextCursor,
    num? total,
  }) =>
      Pagination(
        isLastPage: isLastPage ?? _isLastPage,
        nextCursor: nextCursor ?? _nextCursor,
        total: total ?? _total,
      );

  bool? get isLastPage => _isLastPage;

  num? get nextCursor => _nextCursor;

  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_last_page'] = _isLastPage;
    map['next_cursor'] = _nextCursor;
    map['total'] = _total;
    return map;
  }
}

class StreamData {
  StreamData({
    num? streamId,
    String? titleUrl,
    String? title,
    String? content,
    String? contentOriginal,
    String? createdAt,
    String? createdDisplay,
    String? updatedAt,
    User? user,
    Status? status,
    num? totalReplies,
    num? totalLikes,
    dynamic repostedFrom,
    String? likers,
    String? type,
    List<String>? images,
    List<dynamic>? polling,
    List<dynamic>? attachment,
    num? parentStreamId,
    List<dynamic>? reports,
    NewsFeed? newsFeed,
    List<dynamic>? targetPrice,
    dynamic analytics,
    num? lastReplyDate,
    List<String>? topics,
    dynamic lastReply,
    List<dynamic>? maskHtml,
    List<dynamic>? imagesData,
    String? imageFrameType,
    String? commenterType,
    FollowingActivity? followingActivity,
    dynamic sharetradeInfo,
    num? replyTo,
    dynamic replyContent,
    dynamic research,
  }) {
    _streamId = streamId;
    _titleUrl = titleUrl;
    _title = title;
    _content = content;
    _contentOriginal = contentOriginal;
    _createdAt = createdAt;
    _createdDisplay = createdDisplay;
    _updatedAt = updatedAt;
    _user = user;
    _status = status;
    _totalReplies = totalReplies;
    _totalLikes = totalLikes;
    _repostedFrom = repostedFrom;
    _likers = likers;
    _type = type;
    _images = images;
    _polling = polling;
    _attachment = attachment;
    _parentStreamId = parentStreamId;
    _reports = reports;
    _newsFeed = newsFeed;
    _targetPrice = targetPrice;
    _analytics = analytics;
    _lastReplyDate = lastReplyDate;
    _topics = topics;
    _lastReply = lastReply;
    _maskHtml = maskHtml;
    _imagesData = imagesData;
    _imageFrameType = imageFrameType;
    _commenterType = commenterType;
    _followingActivity = followingActivity;
    _sharetradeInfo = sharetradeInfo;
    _replyTo = replyTo;
    _replyContent = replyContent;
    _research = research;
  }

  StreamData.fromJson(dynamic json) {
    _streamId = json['stream_id'];
    _titleUrl = json['title_url'];
    _title = json['title'];
    _content = json['content'];
    _contentOriginal = json['content_original'];
    _createdAt = json['created_at'];
    _createdDisplay = json['created_display'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
    _totalReplies = json['total_replies'];
    _totalLikes = json['total_likes'];
    _repostedFrom = json['reposted_from'];
    _likers = json['likers'];
    _type = json['type'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['polling'] != null) {
      _polling = [];
      // json['polling'].forEach((v) {
      //   _polling?.add(Dynamic.fromJson(v));
      // });
    }
    if (json['attachment'] != null) {
      _attachment = [];
      // json['attachment'].forEach((v) {
      //   _attachment?.add(Dynamic.fromJson(v));
      // });
    }
    _parentStreamId = json['parent_stream_id'];
    if (json['reports'] != null) {
      _reports = [];
      // json['reports'].forEach((v) {
      //   _reports?.add(Dynamic.fromJson(v));
      // });
    }
    _newsFeed =
        json['news_feed'] != null ? NewsFeed.fromJson(json['news_feed']) : null;
    if (json['target_price'] != null) {
      _targetPrice = [];
      json['target_price'].forEach((v) {
        // _targetPrice?.add(Dynamic.fromJson(v));
      });
    }
    _analytics = json['analytics'];
    _lastReplyDate = json['last_reply_date'];
    _topics = json['topics'] != null ? json['topics'].cast<String>() : [];
    _lastReply = json['last_reply'];
    if (json['mask_html'] != null) {
      _maskHtml = [];
      json['mask_html'].forEach((v) {
        // _maskHtml?.add(Dynamic.fromJson(v));
      });
    }
    if (json['images_data'] != null) {
      _imagesData = [];
      json['images_data'].forEach((v) {
        // _imagesData?.add(Dynamic.fromJson(v));
      });
    }
    _imageFrameType = json['image_frame_type'];
    _commenterType = json['commenter_type'];
    _followingActivity = json['following_activity'] != null
        ? FollowingActivity.fromJson(json['following_activity'])
        : null;
    _sharetradeInfo = json['sharetrade_info'];
    _replyTo = json['reply_to'];
    _replyContent = json['reply_content'];
    _research = json['research'];
  }

  num? _streamId;
  String? _titleUrl;
  String? _title;
  String? _content;
  String? _contentOriginal;
  String? _createdAt;
  String? _createdDisplay;
  String? _updatedAt;
  User? _user;
  Status? _status;
  num? _totalReplies;
  num? _totalLikes;
  dynamic _repostedFrom;
  String? _likers;
  String? _type;
  List<String>? _images;
  List<dynamic>? _polling;
  List<dynamic>? _attachment;
  num? _parentStreamId;
  List<dynamic>? _reports;
  NewsFeed? _newsFeed;
  List<dynamic>? _targetPrice;
  dynamic _analytics;
  num? _lastReplyDate;
  List<String>? _topics;
  dynamic _lastReply;
  List<dynamic>? _maskHtml;
  List<dynamic>? _imagesData;
  String? _imageFrameType;
  String? _commenterType;
  FollowingActivity? _followingActivity;
  dynamic _sharetradeInfo;
  num? _replyTo;
  dynamic _replyContent;
  dynamic _research;

  StreamData copyWith({
    num? streamId,
    String? titleUrl,
    String? title,
    String? content,
    String? contentOriginal,
    String? createdAt,
    String? createdDisplay,
    String? updatedAt,
    User? user,
    Status? status,
    num? totalReplies,
    num? totalLikes,
    dynamic repostedFrom,
    String? likers,
    String? type,
    List<String>? images,
    List<dynamic>? polling,
    List<dynamic>? attachment,
    num? parentStreamId,
    List<dynamic>? reports,
    NewsFeed? newsFeed,
    List<dynamic>? targetPrice,
    dynamic analytics,
    num? lastReplyDate,
    List<String>? topics,
    dynamic lastReply,
    List<dynamic>? maskHtml,
    List<dynamic>? imagesData,
    String? imageFrameType,
    String? commenterType,
    FollowingActivity? followingActivity,
    dynamic sharetradeInfo,
    num? replyTo,
    dynamic replyContent,
    dynamic research,
  }) =>
      StreamData(
        streamId: streamId ?? _streamId,
        titleUrl: titleUrl ?? _titleUrl,
        title: title ?? _title,
        content: content ?? _content,
        contentOriginal: contentOriginal ?? _contentOriginal,
        createdAt: createdAt ?? _createdAt,
        createdDisplay: createdDisplay ?? _createdDisplay,
        updatedAt: updatedAt ?? _updatedAt,
        user: user ?? _user,
        status: status ?? _status,
        totalReplies: totalReplies ?? _totalReplies,
        totalLikes: totalLikes ?? _totalLikes,
        repostedFrom: repostedFrom ?? _repostedFrom,
        likers: likers ?? _likers,
        type: type ?? _type,
        images: images ?? _images,
        polling: polling ?? _polling,
        attachment: attachment ?? _attachment,
        parentStreamId: parentStreamId ?? _parentStreamId,
        reports: reports ?? _reports,
        newsFeed: newsFeed ?? _newsFeed,
        targetPrice: targetPrice ?? _targetPrice,
        analytics: analytics ?? _analytics,
        lastReplyDate: lastReplyDate ?? _lastReplyDate,
        topics: topics ?? _topics,
        lastReply: lastReply ?? _lastReply,
        maskHtml: maskHtml ?? _maskHtml,
        imagesData: imagesData ?? _imagesData,
        imageFrameType: imageFrameType ?? _imageFrameType,
        commenterType: commenterType ?? _commenterType,
        followingActivity: followingActivity ?? _followingActivity,
        sharetradeInfo: sharetradeInfo ?? _sharetradeInfo,
        replyTo: replyTo ?? _replyTo,
        replyContent: replyContent ?? _replyContent,
        research: research ?? _research,
      );

  num? get streamId => _streamId;

  String? get titleUrl => _titleUrl;

  String? get title => _title;

  String? get content => _content;

  String? get contentOriginal => _contentOriginal;

  String? get createdAt => _createdAt;

  String? get createdDisplay => _createdDisplay;

  String? get updatedAt => _updatedAt;

  User? get user => _user;

  Status? get status => _status;

  num? get totalReplies => _totalReplies;

  num? get totalLikes => _totalLikes;

  dynamic get repostedFrom => _repostedFrom;

  String? get likers => _likers;

  String? get type => _type;

  List<String>? get images => _images;

  List<dynamic>? get polling => _polling;

  List<dynamic>? get attachment => _attachment;

  num? get parentStreamId => _parentStreamId;

  List<dynamic>? get reports => _reports;

  NewsFeed? get newsFeed => _newsFeed;

  List<dynamic>? get targetPrice => _targetPrice;

  dynamic get analytics => _analytics;

  num? get lastReplyDate => _lastReplyDate;

  List<String>? get topics => _topics;

  dynamic get lastReply => _lastReply;

  List<dynamic>? get maskHtml => _maskHtml;

  List<dynamic>? get imagesData => _imagesData;

  String? get imageFrameType => _imageFrameType;

  String? get commenterType => _commenterType;

  FollowingActivity? get followingActivity => _followingActivity;

  dynamic get sharetradeInfo => _sharetradeInfo;

  num? get replyTo => _replyTo;

  dynamic get replyContent => _replyContent;

  dynamic get research => _research;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stream_id'] = _streamId;
    map['title_url'] = _titleUrl;
    map['title'] = _title;
    map['content'] = _content;
    map['content_original'] = _contentOriginal;
    map['created_at'] = _createdAt;
    map['created_display'] = _createdDisplay;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    map['total_replies'] = _totalReplies;
    map['total_likes'] = _totalLikes;
    map['reposted_from'] = _repostedFrom;
    map['likers'] = _likers;
    map['type'] = _type;
    map['images'] = _images;
    if (_polling != null) {
      map['polling'] = _polling?.map((v) => v.toJson()).toList();
    }
    if (_attachment != null) {
      map['attachment'] = _attachment?.map((v) => v.toJson()).toList();
    }
    map['parent_stream_id'] = _parentStreamId;
    if (_reports != null) {
      map['reports'] = _reports?.map((v) => v.toJson()).toList();
    }
    if (_newsFeed != null) {
      map['news_feed'] = _newsFeed?.toJson();
    }
    if (_targetPrice != null) {
      map['target_price'] = _targetPrice?.map((v) => v.toJson()).toList();
    }
    map['analytics'] = _analytics;
    map['last_reply_date'] = _lastReplyDate;
    map['topics'] = _topics;
    map['last_reply'] = _lastReply;
    if (_maskHtml != null) {
      map['mask_html'] = _maskHtml?.map((v) => v.toJson()).toList();
    }
    if (_imagesData != null) {
      map['images_data'] = _imagesData?.map((v) => v.toJson()).toList();
    }
    map['image_frame_type'] = _imageFrameType;
    map['commenter_type'] = _commenterType;
    if (_followingActivity != null) {
      map['following_activity'] = _followingActivity?.toJson();
    }
    map['sharetrade_info'] = _sharetradeInfo;
    map['reply_to'] = _replyTo;
    map['reply_content'] = _replyContent;
    map['research'] = _research;
    return map;
  }
}

class FollowingActivity {
  FollowingActivity({
    List<dynamic>? users,
    String? info,
  }) {
    _users = users;
    _info = info;
  }

  FollowingActivity.fromJson(dynamic json) {
    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        // _users?.add(Dynamic.fromJson(v));
      });
    }
    _info = json['info'];
  }

  List<dynamic>? _users;
  String? _info;

  FollowingActivity copyWith({
    List<dynamic>? users,
    String? info,
  }) =>
      FollowingActivity(
        users: users ?? _users,
        info: info ?? _info,
      );

  List<dynamic>? get users => _users;

  String? get info => _info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    map['info'] = _info;
    return map;
  }
}

class NewsFeed {
  NewsFeed({
    String? source,
    String? label,
    String? img,
  }) {
    _source = source;
    _label = label;
    _img = img;
  }

  NewsFeed.fromJson(dynamic json) {
    _source = json['source'];
    _label = json['label'];
    _img = json['img'];
  }

  String? _source;
  String? _label;
  String? _img;

  NewsFeed copyWith({
    String? source,
    String? label,
    String? img,
  }) =>
      NewsFeed(
        source: source ?? _source,
        label: label ?? _label,
        img: img ?? _img,
      );

  String? get source => _source;

  String? get label => _label;

  String? get img => _img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['source'] = _source;
    map['label'] = _label;
    map['img'] = _img;
    return map;
  }
}

class Status {
  Status({
    bool? isPinned,
    bool? isTrending,
    bool? isReposted,
    bool? isLiked,
    bool? isSaved,
    bool? isFollowed,
    bool? isUnavailable,
  }) {
    _isPinned = isPinned;
    _isTrending = isTrending;
    _isReposted = isReposted;
    _isLiked = isLiked;
    _isSaved = isSaved;
    _isFollowed = isFollowed;
    _isUnavailable = isUnavailable;
  }

  Status.fromJson(dynamic json) {
    _isPinned = json['is_pinned'];
    _isTrending = json['is_trending'];
    _isReposted = json['is_reposted'];
    _isLiked = json['is_liked'];
    _isSaved = json['is_saved'];
    _isFollowed = json['is_followed'];
    _isUnavailable = json['is_unavailable'];
  }

  bool? _isPinned;
  bool? _isTrending;
  bool? _isReposted;
  bool? _isLiked;
  bool? _isSaved;
  bool? _isFollowed;
  bool? _isUnavailable;

  Status copyWith({
    bool? isPinned,
    bool? isTrending,
    bool? isReposted,
    bool? isLiked,
    bool? isSaved,
    bool? isFollowed,
    bool? isUnavailable,
  }) =>
      Status(
        isPinned: isPinned ?? _isPinned,
        isTrending: isTrending ?? _isTrending,
        isReposted: isReposted ?? _isReposted,
        isLiked: isLiked ?? _isLiked,
        isSaved: isSaved ?? _isSaved,
        isFollowed: isFollowed ?? _isFollowed,
        isUnavailable: isUnavailable ?? _isUnavailable,
      );

  bool? get isPinned => _isPinned;

  bool? get isTrending => _isTrending;

  bool? get isReposted => _isReposted;

  bool? get isLiked => _isLiked;

  bool? get isSaved => _isSaved;

  bool? get isFollowed => _isFollowed;

  bool? get isUnavailable => _isUnavailable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_pinned'] = _isPinned;
    map['is_trending'] = _isTrending;
    map['is_reposted'] = _isReposted;
    map['is_liked'] = _isLiked;
    map['is_saved'] = _isSaved;
    map['is_followed'] = _isFollowed;
    map['is_unavailable'] = _isUnavailable;
    return map;
  }
}

class User {
  User({
    num? userId,
    bool? isAuthor,
    String? username,
    String? fullname,
    String? avatar,
    bool? isVerified,
    String? userPrivilege,
    bool? isPro,
    String? country,
  }) {
    _userId = userId;
    _isAuthor = isAuthor;
    _username = username;
    _fullname = fullname;
    _avatar = avatar;
    _isVerified = isVerified;
    _userPrivilege = userPrivilege;
    _isPro = isPro;
    _country = country;
  }

  User.fromJson(dynamic json) {
    _userId = json['user_id'];
    _isAuthor = json['is_author'];
    _username = json['username'];
    _fullname = json['fullname'];
    _avatar = json['avatar'];
    _isVerified = json['is_verified'];
    _userPrivilege = json['user_privilege'];
    _isPro = json['is_pro'];
    _country = json['country'];
  }

  num? _userId;
  bool? _isAuthor;
  String? _username;
  String? _fullname;
  String? _avatar;
  bool? _isVerified;
  String? _userPrivilege;
  bool? _isPro;
  String? _country;

  User copyWith({
    num? userId,
    bool? isAuthor,
    String? username,
    String? fullname,
    String? avatar,
    bool? isVerified,
    String? userPrivilege,
    bool? isPro,
    String? country,
  }) =>
      User(
        userId: userId ?? _userId,
        isAuthor: isAuthor ?? _isAuthor,
        username: username ?? _username,
        fullname: fullname ?? _fullname,
        avatar: avatar ?? _avatar,
        isVerified: isVerified ?? _isVerified,
        userPrivilege: userPrivilege ?? _userPrivilege,
        isPro: isPro ?? _isPro,
        country: country ?? _country,
      );

  num? get userId => _userId;

  bool? get isAuthor => _isAuthor;

  String? get username => _username;

  String? get fullname => _fullname;

  String? get avatar => _avatar;

  bool? get isVerified => _isVerified;

  String? get userPrivilege => _userPrivilege;

  bool? get isPro => _isPro;

  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['is_author'] = _isAuthor;
    map['username'] = _username;
    map['fullname'] = _fullname;
    map['avatar'] = _avatar;
    map['is_verified'] = _isVerified;
    map['user_privilege'] = _userPrivilege;
    map['is_pro'] = _isPro;
    map['country'] = _country;
    return map;
  }
}
