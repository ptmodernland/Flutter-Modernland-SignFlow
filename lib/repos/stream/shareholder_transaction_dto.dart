class ShareholderTransactionDto {
  ShareholderTransactionDto({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  ShareholderTransactionDto.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _message;
  Data? _data;

  ShareholderTransactionDto copyWith({
    String? message,
    Data? data,
  }) =>
      ShareholderTransactionDto(
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    bool? isMore,
    List<ShareholderMovementDTO>? movement,
  }) {
    _isMore = isMore;
    _movement = movement;
  }

  Data.fromJson(dynamic json) {
    _isMore = json['is_more'];
    if (json['movement'] != null) {
      _movement = [];
      json['movement'].forEach((v) {
        _movement?.add(ShareholderMovementDTO.fromJson(v));
      });
    }
  }

  bool? _isMore;
  List<ShareholderMovementDTO>? _movement;

  Data copyWith({
    bool? isMore,
    List<ShareholderMovementDTO>? movement,
  }) =>
      Data(
        isMore: isMore ?? _isMore,
        movement: movement ?? _movement,
      );

  bool? get isMore => _isMore;

  List<ShareholderMovementDTO>? get movement => _movement;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_more'] = _isMore;
    if (_movement != null) {
      map['movement'] = _movement?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ShareholderMovementDTO {
  ShareholderMovementDTO({
    String? id,
    String? name,
    String? symbol,
    String? date,
    Previous? previous,
    Current? current,
    Changes? changes,
    String? marker,
    bool? isPosted,
    String? cmhId,
    String? nationality,
  }) {
    _id = id;
    _name = name;
    _symbol = symbol;
    _date = date;
    _previous = previous;
    _current = current;
    _changes = changes;
    _marker = marker;
    _isPosted = isPosted;
    _cmhId = cmhId;
    _nationality = nationality;
  }

  ShareholderMovementDTO.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _symbol = json['symbol'];
    _date = json['date'];
    _previous =
        json['previous'] != null ? Previous.fromJson(json['previous']) : null;
    _current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    _changes =
        json['changes'] != null ? Changes.fromJson(json['changes']) : null;
    _marker = json['marker'];
    _isPosted = json['is_posted'];
    _cmhId = json['cmh_id'];
    _nationality = json['nationality'];
  }

  String? _id;
  String? _name;
  String? _symbol;
  String? _date;
  Previous? _previous;
  Current? _current;
  Changes? _changes;
  String? _marker;
  bool? _isPosted;
  String? _cmhId;
  String? _nationality;

  ShareholderMovementDTO copyWith({
    String? id,
    String? name,
    String? symbol,
    String? date,
    Previous? previous,
    Current? current,
    Changes? changes,
    String? marker,
    bool? isPosted,
    String? cmhId,
    String? nationality,
  }) =>
      ShareholderMovementDTO(
        id: id ?? _id,
        name: name ?? _name,
        symbol: symbol ?? _symbol,
        date: date ?? _date,
        previous: previous ?? _previous,
        current: current ?? _current,
        changes: changes ?? _changes,
        marker: marker ?? _marker,
        isPosted: isPosted ?? _isPosted,
        cmhId: cmhId ?? _cmhId,
        nationality: nationality ?? _nationality,
      );

  String? get id => _id;

  String? get name => _name;

  String? get symbol => _symbol;

  String? get date => _date;

  Previous? get previous => _previous;

  Current? get current => _current;

  Changes? get changes => _changes;

  String? get marker => _marker;

  bool? get isPosted => _isPosted;

  String? get cmhId => _cmhId;

  String? get nationality => _nationality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['symbol'] = _symbol;
    map['date'] = _date;
    if (_previous != null) {
      map['previous'] = _previous?.toJson();
    }
    if (_current != null) {
      map['current'] = _current?.toJson();
    }
    if (_changes != null) {
      map['changes'] = _changes?.toJson();
    }
    map['marker'] = _marker;
    map['is_posted'] = _isPosted;
    map['cmh_id'] = _cmhId;
    map['nationality'] = _nationality;
    return map;
  }
}

class Changes {
  Changes({
    String? value,
    String? percentage,
  }) {
    _value = value;
    _percentage = percentage;
  }

  Changes.fromJson(dynamic json) {
    _value = json['value'];
    _percentage = json['percentage'];
  }

  String? _value;
  String? _percentage;

  Changes copyWith({
    String? value,
    String? percentage,
  }) =>
      Changes(
        value: value ?? _value,
        percentage: percentage ?? _percentage,
      );

  String? get value => _value;

  String? get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['percentage'] = _percentage;
    return map;
  }
}

class Current {
  Current({
    String? value,
    String? percentage,
  }) {
    _value = value;
    _percentage = percentage;
  }

  Current.fromJson(dynamic json) {
    _value = json['value'];
    _percentage = json['percentage'];
  }

  String? _value;
  String? _percentage;

  Current copyWith({
    String? value,
    String? percentage,
  }) =>
      Current(
        value: value ?? _value,
        percentage: percentage ?? _percentage,
      );

  String? get value => _value;

  String? get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['percentage'] = _percentage;
    return map;
  }
}

class Previous {
  Previous({
    String? value,
    String? percentage,
  }) {
    _value = value;
    _percentage = percentage;
  }

  Previous.fromJson(dynamic json) {
    _value = json['value'];
    _percentage = json['percentage'];
  }

  String? _value;
  String? _percentage;

  Previous copyWith({
    String? value,
    String? percentage,
  }) =>
      Previous(
        value: value ?? _value,
        percentage: percentage ?? _percentage,
      );

  String? get value => _value;

  String? get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['percentage'] = _percentage;
    return map;
  }
}
