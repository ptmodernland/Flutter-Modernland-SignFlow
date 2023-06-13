class OrderbookDto {
  OrderbookDto({
    Data? data,
    String? message,
  }) {
    _data = data;
    _message = message;
  }

  OrderbookDto.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }

  Data? _data;
  String? _message;

  OrderbookDto copyWith({
    Data? data,
    String? message,
  }) =>
      OrderbookDto(
        data: data ?? _data,
        message: message ?? _message,
      );

  Data? get data => _data;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }
}

class Data {
  Data({
    num? average,
    Bid? bid,
    num? change,
    num? close,
    String? country,
    String? domestic,
    String? down,
    String? exchange,
    num? fbuy,
    num? fnet,
    String? foreign,
    num? frequency,
    num? fsell,
    num? high,
    String? id,
    num? lastprice,
    num? low,
    Offer? offer,
    num? open,
    num? percentageChange,
    num? previous,
    String? status,
    String? symbol,
    String? symbol2,
    String? symbol3,
    num? tradeable,
    String? unchanged,
    String? up,
    num? value,
    num? volume,
    CorpAction? corpAction,
    List<dynamic>? notation,
    bool? uma,
    bool? isForeignbsExist,
    dynamic iepiev,
    List<MarketData>? marketData,
  }) {
    _average = average;
    _bid = bid;
    _change = change;
    _close = close;
    _country = country;
    _domestic = domestic;
    _down = down;
    _exchange = exchange;
    _fbuy = fbuy;
    _fnet = fnet;
    _foreign = foreign;
    _frequency = frequency;
    _fsell = fsell;
    _high = high;
    _id = id;
    _lastprice = lastprice;
    _low = low;
    _offer = offer;
    _open = open;
    _percentageChange = percentageChange;
    _previous = previous;
    _status = status;
    _symbol = symbol;
    _symbol2 = symbol2;
    _symbol3 = symbol3;
    _tradeable = tradeable;
    _unchanged = unchanged;
    _up = up;
    _value = value;
    _volume = volume;
    _corpAction = corpAction;
    _notation = notation;
    _uma = uma;
    _isForeignbsExist = isForeignbsExist;
    _iepiev = iepiev;
    _marketData = marketData;
  }

  Data.fromJson(dynamic json) {
    _average = json['average'];
    _bid = json['bid'] != null ? Bid.fromJson(json['bid']) : null;
    _change = json['change'];
    _close = json['close'];
    _country = json['country'];
    _domestic = json['domestic'];
    _down = json['down'];
    _exchange = json['exchange'];
    _fbuy = json['fbuy'];
    _fnet = json['fnet'];
    _foreign = json['foreign'];
    _frequency = json['frequency'];
    _fsell = json['fsell'];
    _high = json['high'];
    _id = json['id'];
    _lastprice = json['lastprice'];
    _low = json['low'];
    _offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
    _open = json['open'];
    _percentageChange = json['percentage_change'];
    _previous = json['previous'];
    _status = json['status'];
    _symbol = json['symbol'];
    _symbol2 = json['symbol_2'];
    _symbol3 = json['symbol_3'];
    _tradeable = json['tradeable'];
    _unchanged = json['unchanged'];
    _up = json['up'];
    _value = json['value'];
    _volume = json['volume'];
    _corpAction = json['corp_action'] != null
        ? CorpAction.fromJson(json['corp_action'])
        : null;
    if (json['notation'] != null) {
      _notation = [];
      json['notation'].forEach((v) {
        // _notation?.add(Dynamic.fromJson(v));
      });
    }
    _uma = json['uma'];
    _isForeignbsExist = json['is_foreignbs_exist'];
    _iepiev = json['iepiev'];
    if (json['market_data'] != null) {
      _marketData = [];
      json['market_data'].forEach((v) {
        _marketData?.add(MarketData.fromJson(v));
      });
    }
  }

  num? _average;
  Bid? _bid;
  num? _change;
  num? _close;
  String? _country;
  String? _domestic;
  String? _down;
  String? _exchange;
  num? _fbuy;
  num? _fnet;
  String? _foreign;
  num? _frequency;
  num? _fsell;
  num? _high;
  String? _id;
  num? _lastprice;
  num? _low;
  Offer? _offer;
  num? _open;
  num? _percentageChange;
  num? _previous;
  String? _status;
  String? _symbol;
  String? _symbol2;
  String? _symbol3;
  num? _tradeable;
  String? _unchanged;
  String? _up;
  num? _value;
  num? _volume;
  CorpAction? _corpAction;
  List<dynamic>? _notation;
  bool? _uma;
  bool? _isForeignbsExist;
  dynamic _iepiev;
  List<MarketData>? _marketData;

  Data copyWith({
    num? average,
    Bid? bid,
    num? change,
    num? close,
    String? country,
    String? domestic,
    String? down,
    String? exchange,
    num? fbuy,
    num? fnet,
    String? foreign,
    num? frequency,
    num? fsell,
    num? high,
    String? id,
    num? lastprice,
    num? low,
    Offer? offer,
    num? open,
    num? percentageChange,
    num? previous,
    String? status,
    String? symbol,
    String? symbol2,
    String? symbol3,
    num? tradeable,
    String? unchanged,
    String? up,
    num? value,
    num? volume,
    CorpAction? corpAction,
    List<dynamic>? notation,
    bool? uma,
    bool? isForeignbsExist,
    dynamic iepiev,
    List<MarketData>? marketData,
  }) =>
      Data(
        average: average ?? _average,
        bid: bid ?? _bid,
        change: change ?? _change,
        close: close ?? _close,
        country: country ?? _country,
        domestic: domestic ?? _domestic,
        down: down ?? _down,
        exchange: exchange ?? _exchange,
        fbuy: fbuy ?? _fbuy,
        fnet: fnet ?? _fnet,
        foreign: foreign ?? _foreign,
        frequency: frequency ?? _frequency,
        fsell: fsell ?? _fsell,
        high: high ?? _high,
        id: id ?? _id,
        lastprice: lastprice ?? _lastprice,
        low: low ?? _low,
        offer: offer ?? _offer,
        open: open ?? _open,
        percentageChange: percentageChange ?? _percentageChange,
        previous: previous ?? _previous,
        status: status ?? _status,
        symbol: symbol ?? _symbol,
        symbol2: symbol2 ?? _symbol2,
        symbol3: symbol3 ?? _symbol3,
        tradeable: tradeable ?? _tradeable,
        unchanged: unchanged ?? _unchanged,
        up: up ?? _up,
        value: value ?? _value,
        volume: volume ?? _volume,
        corpAction: corpAction ?? _corpAction,
        notation: notation ?? _notation,
        uma: uma ?? _uma,
        isForeignbsExist: isForeignbsExist ?? _isForeignbsExist,
        iepiev: iepiev ?? _iepiev,
        marketData: marketData ?? _marketData,
      );

  num? get average => _average;

  Bid? get bid => _bid;

  num? get change => _change;

  num? get close => _close;

  String? get country => _country;

  String? get domestic => _domestic;

  String? get down => _down;

  String? get exchange => _exchange;

  num? get fbuy => _fbuy;

  num? get fnet => _fnet;

  String? get foreign => _foreign;

  num? get frequency => _frequency;

  num? get fsell => _fsell;

  num? get high => _high;

  String? get id => _id;

  num? get lastprice => _lastprice;

  num? get low => _low;

  Offer? get offer => _offer;

  num? get open => _open;

  num? get percentageChange => _percentageChange;

  num? get previous => _previous;

  String? get status => _status;

  String? get symbol => _symbol;

  String? get symbol2 => _symbol2;

  String? get symbol3 => _symbol3;

  num? get tradeable => _tradeable;

  String? get unchanged => _unchanged;

  String? get up => _up;

  num? get value => _value;

  num? get volume => _volume;

  CorpAction? get corpAction => _corpAction;

  List<dynamic>? get notation => _notation;

  bool? get uma => _uma;

  bool? get isForeignbsExist => _isForeignbsExist;

  dynamic get iepiev => _iepiev;

  List<MarketData>? get marketData => _marketData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['average'] = _average;
    if (_bid != null) {
      map['bid'] = _bid?.toJson();
    }
    map['change'] = _change;
    map['close'] = _close;
    map['country'] = _country;
    map['domestic'] = _domestic;
    map['down'] = _down;
    map['exchange'] = _exchange;
    map['fbuy'] = _fbuy;
    map['fnet'] = _fnet;
    map['foreign'] = _foreign;
    map['frequency'] = _frequency;
    map['fsell'] = _fsell;
    map['high'] = _high;
    map['id'] = _id;
    map['lastprice'] = _lastprice;
    map['low'] = _low;
    if (_offer != null) {
      map['offer'] = _offer?.toJson();
    }
    map['open'] = _open;
    map['percentage_change'] = _percentageChange;
    map['previous'] = _previous;
    map['status'] = _status;
    map['symbol'] = _symbol;
    map['symbol_2'] = _symbol2;
    map['symbol_3'] = _symbol3;
    map['tradeable'] = _tradeable;
    map['unchanged'] = _unchanged;
    map['up'] = _up;
    map['value'] = _value;
    map['volume'] = _volume;
    if (_corpAction != null) {
      map['corp_action'] = _corpAction?.toJson();
    }
    if (_notation != null) {
      map['notation'] = _notation?.map((v) => v.toJson()).toList();
    }
    map['uma'] = _uma;
    map['is_foreignbs_exist'] = _isForeignbsExist;
    map['iepiev'] = _iepiev;
    if (_marketData != null) {
      map['market_data'] = _marketData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MarketData {
  MarketData({
    String? label,
    Frequency? frequency,
    Volume? volume,
    Value? value,
  }) {
    _label = label;
    _frequency = frequency;
    _volume = volume;
    _value = value;
  }

  MarketData.fromJson(dynamic json) {
    _label = json['label'];
    _frequency = json['frequency'] != null
        ? Frequency.fromJson(json['frequency'])
        : null;
    _volume = json['volume'] != null ? Volume.fromJson(json['volume']) : null;
    _value = json['value'] != null ? Value.fromJson(json['value']) : null;
  }

  String? _label;
  Frequency? _frequency;
  Volume? _volume;
  Value? _value;

  MarketData copyWith({
    String? label,
    Frequency? frequency,
    Volume? volume,
    Value? value,
  }) =>
      MarketData(
        label: label ?? _label,
        frequency: frequency ?? _frequency,
        volume: volume ?? _volume,
        value: value ?? _value,
      );

  String? get label => _label;

  Frequency? get frequency => _frequency;

  Volume? get volume => _volume;

  Value? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = _label;
    if (_frequency != null) {
      map['frequency'] = _frequency?.toJson();
    }
    if (_volume != null) {
      map['volume'] = _volume?.toJson();
    }
    if (_value != null) {
      map['value'] = _value?.toJson();
    }
    return map;
  }
}

class Value {
  Value({
    String? raw,
    String? formatted,
  }) {
    _raw = raw;
    _formatted = formatted;
  }

  Value.fromJson(dynamic json) {
    _raw = json['raw'];
    _formatted = json['formatted'];
  }

  String? _raw;
  String? _formatted;

  Value copyWith({
    String? raw,
    String? formatted,
  }) =>
      Value(
        raw: raw ?? _raw,
        formatted: formatted ?? _formatted,
      );

  String? get raw => _raw;

  String? get formatted => _formatted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = _raw;
    map['formatted'] = _formatted;
    return map;
  }
}

class Volume {
  Volume({
    String? raw,
    String? formatted,
  }) {
    _raw = raw;
    _formatted = formatted;
  }

  Volume.fromJson(dynamic json) {
    _raw = json['raw'];
    _formatted = json['formatted'];
  }

  String? _raw;
  String? _formatted;

  Volume copyWith({
    String? raw,
    String? formatted,
  }) =>
      Volume(
        raw: raw ?? _raw,
        formatted: formatted ?? _formatted,
      );

  String? get raw => _raw;

  String? get formatted => _formatted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = _raw;
    map['formatted'] = _formatted;
    return map;
  }
}

class Frequency {
  Frequency({
    String? raw,
    String? formatted,
  }) {
    _raw = raw;
    _formatted = formatted;
  }

  Frequency.fromJson(dynamic json) {
    _raw = json['raw'];
    _formatted = json['formatted'];
  }

  String? _raw;
  String? _formatted;

  Frequency copyWith({
    String? raw,
    String? formatted,
  }) =>
      Frequency(
        raw: raw ?? _raw,
        formatted: formatted ?? _formatted,
      );

  String? get raw => _raw;

  String? get formatted => _formatted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['raw'] = _raw;
    map['formatted'] = _formatted;
    return map;
  }
}

class CorpAction {
  CorpAction({
    bool? active,
    String? icon,
    String? text,
  }) {
    _active = active;
    _icon = icon;
    _text = text;
  }

  CorpAction.fromJson(dynamic json) {
    _active = json['active'];
    _icon = json['icon'];
    _text = json['text'];
  }

  bool? _active;
  String? _icon;
  String? _text;

  CorpAction copyWith({
    bool? active,
    String? icon,
    String? text,
  }) =>
      CorpAction(
        active: active ?? _active,
        icon: icon ?? _icon,
        text: text ?? _text,
      );

  bool? get active => _active;

  String? get icon => _icon;

  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active'] = _active;
    map['icon'] = _icon;
    map['text'] = _text;
    return map;
  }
}

class Offer {
  Offer({
    String? price1,
    String? price2,
    String? price3,
    String? price4,
    String? price5,
    String? price6,
    String? price7,
    String? price8,
    String? price9,
    String? price10,
    String? queNum1,
    String? queNum2,
    String? queNum3,
    String? queNum4,
    String? queNum5,
    String? queNum6,
    String? queNum7,
    String? queNum8,
    String? queNum9,
    String? queNum10,
    String? volume1,
    String? volume2,
    String? volume3,
    String? volume4,
    String? volume5,
    String? volume6,
    String? volume7,
    String? volume8,
    String? volume9,
    String? volume10,
  }) {
    _price1 = price1;
    _price2 = price2;
    _price3 = price3;
    _price4 = price4;
    _price5 = price5;
    _price6 = price6;
    _price7 = price7;
    _price8 = price8;
    _price9 = price9;
    _price10 = price10;
    _queNum1 = queNum1;
    _queNum2 = queNum2;
    _queNum3 = queNum3;
    _queNum4 = queNum4;
    _queNum5 = queNum5;
    _queNum6 = queNum6;
    _queNum7 = queNum7;
    _queNum8 = queNum8;
    _queNum9 = queNum9;
    _queNum10 = queNum10;
    _volume1 = volume1;
    _volume2 = volume2;
    _volume3 = volume3;
    _volume4 = volume4;
    _volume5 = volume5;
    _volume6 = volume6;
    _volume7 = volume7;
    _volume8 = volume8;
    _volume9 = volume9;
    _volume10 = volume10;
  }

  Offer.fromJson(dynamic json) {
    _price1 = json['price1'];
    _price2 = json['price2'];
    _price3 = json['price3'];
    _price4 = json['price4'];
    _price5 = json['price5'];
    _price6 = json['price6'];
    _price7 = json['price7'];
    _price8 = json['price8'];
    _price9 = json['price9'];
    _price10 = json['price10'];
    _queNum1 = json['que_num1'];
    _queNum2 = json['que_num2'];
    _queNum3 = json['que_num3'];
    _queNum4 = json['que_num4'];
    _queNum5 = json['que_num5'];
    _queNum6 = json['que_num6'];
    _queNum7 = json['que_num7'];
    _queNum8 = json['que_num8'];
    _queNum9 = json['que_num9'];
    _queNum10 = json['que_num10'];
    _volume1 = json['volume1'];
    _volume2 = json['volume2'];
    _volume3 = json['volume3'];
    _volume4 = json['volume4'];
    _volume5 = json['volume5'];
    _volume6 = json['volume6'];
    _volume7 = json['volume7'];
    _volume8 = json['volume8'];
    _volume9 = json['volume9'];
    _volume10 = json['volume10'];
  }

  String? _price1;
  String? _price2;
  String? _price3;
  String? _price4;
  String? _price5;
  String? _price6;
  String? _price7;
  String? _price8;
  String? _price9;
  String? _price10;
  String? _queNum1;
  String? _queNum2;
  String? _queNum3;
  String? _queNum4;
  String? _queNum5;
  String? _queNum6;
  String? _queNum7;
  String? _queNum8;
  String? _queNum9;
  String? _queNum10;
  String? _volume1;
  String? _volume2;
  String? _volume3;
  String? _volume4;
  String? _volume5;
  String? _volume6;
  String? _volume7;
  String? _volume8;
  String? _volume9;
  String? _volume10;

  Offer copyWith({
    String? price1,
    String? price2,
    String? price3,
    String? price4,
    String? price5,
    String? price6,
    String? price7,
    String? price8,
    String? price9,
    String? price10,
    String? queNum1,
    String? queNum2,
    String? queNum3,
    String? queNum4,
    String? queNum5,
    String? queNum6,
    String? queNum7,
    String? queNum8,
    String? queNum9,
    String? queNum10,
    String? volume1,
    String? volume2,
    String? volume3,
    String? volume4,
    String? volume5,
    String? volume6,
    String? volume7,
    String? volume8,
    String? volume9,
    String? volume10,
  }) =>
      Offer(
        price1: price1 ?? _price1,
        price2: price2 ?? _price2,
        price3: price3 ?? _price3,
        price4: price4 ?? _price4,
        price5: price5 ?? _price5,
        price6: price6 ?? _price6,
        price7: price7 ?? _price7,
        price8: price8 ?? _price8,
        price9: price9 ?? _price9,
        price10: price10 ?? _price10,
        queNum1: queNum1 ?? _queNum1,
        queNum2: queNum2 ?? _queNum2,
        queNum3: queNum3 ?? _queNum3,
        queNum4: queNum4 ?? _queNum4,
        queNum5: queNum5 ?? _queNum5,
        queNum6: queNum6 ?? _queNum6,
        queNum7: queNum7 ?? _queNum7,
        queNum8: queNum8 ?? _queNum8,
        queNum9: queNum9 ?? _queNum9,
        queNum10: queNum10 ?? _queNum10,
        volume1: volume1 ?? _volume1,
        volume2: volume2 ?? _volume2,
        volume3: volume3 ?? _volume3,
        volume4: volume4 ?? _volume4,
        volume5: volume5 ?? _volume5,
        volume6: volume6 ?? _volume6,
        volume7: volume7 ?? _volume7,
        volume8: volume8 ?? _volume8,
        volume9: volume9 ?? _volume9,
        volume10: volume10 ?? _volume10,
      );

  String? get price1 => _price1;

  String? get price2 => _price2;

  String? get price3 => _price3;

  String? get price4 => _price4;

  String? get price5 => _price5;

  String? get price6 => _price6;

  String? get price7 => _price7;

  String? get price8 => _price8;

  String? get price9 => _price9;

  String? get price10 => _price10;

  String? get queNum1 => _queNum1;

  String? get queNum2 => _queNum2;

  String? get queNum3 => _queNum3;

  String? get queNum4 => _queNum4;

  String? get queNum5 => _queNum5;

  String? get queNum6 => _queNum6;

  String? get queNum7 => _queNum7;

  String? get queNum8 => _queNum8;

  String? get queNum9 => _queNum9;

  String? get queNum10 => _queNum10;

  String? get volume1 => _volume1;

  String? get volume2 => _volume2;

  String? get volume3 => _volume3;

  String? get volume4 => _volume4;

  String? get volume5 => _volume5;

  String? get volume6 => _volume6;

  String? get volume7 => _volume7;

  String? get volume8 => _volume8;

  String? get volume9 => _volume9;

  String? get volume10 => _volume10;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price1'] = _price1;
    map['price2'] = _price2;
    map['price3'] = _price3;
    map['price4'] = _price4;
    map['price5'] = _price5;
    map['price6'] = _price6;
    map['price7'] = _price7;
    map['price8'] = _price8;
    map['price9'] = _price9;
    map['price10'] = _price10;
    map['que_num1'] = _queNum1;
    map['que_num2'] = _queNum2;
    map['que_num3'] = _queNum3;
    map['que_num4'] = _queNum4;
    map['que_num5'] = _queNum5;
    map['que_num6'] = _queNum6;
    map['que_num7'] = _queNum7;
    map['que_num8'] = _queNum8;
    map['que_num9'] = _queNum9;
    map['que_num10'] = _queNum10;
    map['volume1'] = _volume1;
    map['volume2'] = _volume2;
    map['volume3'] = _volume3;
    map['volume4'] = _volume4;
    map['volume5'] = _volume5;
    map['volume6'] = _volume6;
    map['volume7'] = _volume7;
    map['volume8'] = _volume8;
    map['volume9'] = _volume9;
    map['volume10'] = _volume10;
    return map;
  }
}

class Bid {
  Bid({
    String? price1,
    String? price2,
    String? price3,
    String? price4,
    String? price5,
    String? price6,
    String? price7,
    String? price8,
    String? price9,
    String? price10,
    String? queNum1,
    String? queNum2,
    String? queNum3,
    String? queNum4,
    String? queNum5,
    String? queNum6,
    String? queNum7,
    String? queNum8,
    String? queNum9,
    String? queNum10,
    String? volume1,
    String? volume2,
    String? volume3,
    String? volume4,
    String? volume5,
    String? volume6,
    String? volume7,
    String? volume8,
    String? volume9,
    String? volume10,
  }) {
    _price1 = price1;
    _price2 = price2;
    _price3 = price3;
    _price4 = price4;
    _price5 = price5;
    _price6 = price6;
    _price7 = price7;
    _price8 = price8;
    _price9 = price9;
    _price10 = price10;
    _queNum1 = queNum1;
    _queNum2 = queNum2;
    _queNum3 = queNum3;
    _queNum4 = queNum4;
    _queNum5 = queNum5;
    _queNum6 = queNum6;
    _queNum7 = queNum7;
    _queNum8 = queNum8;
    _queNum9 = queNum9;
    _queNum10 = queNum10;
    _volume1 = volume1;
    _volume2 = volume2;
    _volume3 = volume3;
    _volume4 = volume4;
    _volume5 = volume5;
    _volume6 = volume6;
    _volume7 = volume7;
    _volume8 = volume8;
    _volume9 = volume9;
    _volume10 = volume10;
  }

  Bid.fromJson(dynamic json) {
    _price1 = json['price1'];
    _price2 = json['price2'];
    _price3 = json['price3'];
    _price4 = json['price4'];
    _price5 = json['price5'];
    _price6 = json['price6'];
    _price7 = json['price7'];
    _price8 = json['price8'];
    _price9 = json['price9'];
    _price10 = json['price10'];
    _queNum1 = json['que_num1'];
    _queNum2 = json['que_num2'];
    _queNum3 = json['que_num3'];
    _queNum4 = json['que_num4'];
    _queNum5 = json['que_num5'];
    _queNum6 = json['que_num6'];
    _queNum7 = json['que_num7'];
    _queNum8 = json['que_num8'];
    _queNum9 = json['que_num9'];
    _queNum10 = json['que_num10'];
    _volume1 = json['volume1'];
    _volume2 = json['volume2'];
    _volume3 = json['volume3'];
    _volume4 = json['volume4'];
    _volume5 = json['volume5'];
    _volume6 = json['volume6'];
    _volume7 = json['volume7'];
    _volume8 = json['volume8'];
    _volume9 = json['volume9'];
    _volume10 = json['volume10'];
  }

  String? _price1;
  String? _price2;
  String? _price3;
  String? _price4;
  String? _price5;
  String? _price6;
  String? _price7;
  String? _price8;
  String? _price9;
  String? _price10;
  String? _queNum1;
  String? _queNum2;
  String? _queNum3;
  String? _queNum4;
  String? _queNum5;
  String? _queNum6;
  String? _queNum7;
  String? _queNum8;
  String? _queNum9;
  String? _queNum10;
  String? _volume1;
  String? _volume2;
  String? _volume3;
  String? _volume4;
  String? _volume5;
  String? _volume6;
  String? _volume7;
  String? _volume8;
  String? _volume9;
  String? _volume10;

  Bid copyWith({
    String? price1,
    String? price2,
    String? price3,
    String? price4,
    String? price5,
    String? price6,
    String? price7,
    String? price8,
    String? price9,
    String? price10,
    String? queNum1,
    String? queNum2,
    String? queNum3,
    String? queNum4,
    String? queNum5,
    String? queNum6,
    String? queNum7,
    String? queNum8,
    String? queNum9,
    String? queNum10,
    String? volume1,
    String? volume2,
    String? volume3,
    String? volume4,
    String? volume5,
    String? volume6,
    String? volume7,
    String? volume8,
    String? volume9,
    String? volume10,
  }) =>
      Bid(
        price1: price1 ?? _price1,
        price2: price2 ?? _price2,
        price3: price3 ?? _price3,
        price4: price4 ?? _price4,
        price5: price5 ?? _price5,
        price6: price6 ?? _price6,
        price7: price7 ?? _price7,
        price8: price8 ?? _price8,
        price9: price9 ?? _price9,
        price10: price10 ?? _price10,
        queNum1: queNum1 ?? _queNum1,
        queNum2: queNum2 ?? _queNum2,
        queNum3: queNum3 ?? _queNum3,
        queNum4: queNum4 ?? _queNum4,
        queNum5: queNum5 ?? _queNum5,
        queNum6: queNum6 ?? _queNum6,
        queNum7: queNum7 ?? _queNum7,
        queNum8: queNum8 ?? _queNum8,
        queNum9: queNum9 ?? _queNum9,
        queNum10: queNum10 ?? _queNum10,
        volume1: volume1 ?? _volume1,
        volume2: volume2 ?? _volume2,
        volume3: volume3 ?? _volume3,
        volume4: volume4 ?? _volume4,
        volume5: volume5 ?? _volume5,
        volume6: volume6 ?? _volume6,
        volume7: volume7 ?? _volume7,
        volume8: volume8 ?? _volume8,
        volume9: volume9 ?? _volume9,
        volume10: volume10 ?? _volume10,
      );

  String? get price1 => _price1;

  String? get price2 => _price2;

  String? get price3 => _price3;

  String? get price4 => _price4;

  String? get price5 => _price5;

  String? get price6 => _price6;

  String? get price7 => _price7;

  String? get price8 => _price8;

  String? get price9 => _price9;

  String? get price10 => _price10;

  String? get queNum1 => _queNum1;

  String? get queNum2 => _queNum2;

  String? get queNum3 => _queNum3;

  String? get queNum4 => _queNum4;

  String? get queNum5 => _queNum5;

  String? get queNum6 => _queNum6;

  String? get queNum7 => _queNum7;

  String? get queNum8 => _queNum8;

  String? get queNum9 => _queNum9;

  String? get queNum10 => _queNum10;

  String? get volume1 => _volume1;

  String? get volume2 => _volume2;

  String? get volume3 => _volume3;

  String? get volume4 => _volume4;

  String? get volume5 => _volume5;

  String? get volume6 => _volume6;

  String? get volume7 => _volume7;

  String? get volume8 => _volume8;

  String? get volume9 => _volume9;

  String? get volume10 => _volume10;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price1'] = _price1;
    map['price2'] = _price2;
    map['price3'] = _price3;
    map['price4'] = _price4;
    map['price5'] = _price5;
    map['price6'] = _price6;
    map['price7'] = _price7;
    map['price8'] = _price8;
    map['price9'] = _price9;
    map['price10'] = _price10;
    map['que_num1'] = _queNum1;
    map['que_num2'] = _queNum2;
    map['que_num3'] = _queNum3;
    map['que_num4'] = _queNum4;
    map['que_num5'] = _queNum5;
    map['que_num6'] = _queNum6;
    map['que_num7'] = _queNum7;
    map['que_num8'] = _queNum8;
    map['que_num9'] = _queNum9;
    map['que_num10'] = _queNum10;
    map['volume1'] = _volume1;
    map['volume2'] = _volume2;
    map['volume3'] = _volume3;
    map['volume4'] = _volume4;
    map['volume5'] = _volume5;
    map['volume6'] = _volume6;
    map['volume7'] = _volume7;
    map['volume8'] = _volume8;
    map['volume9'] = _volume9;
    map['volume10'] = _volume10;
    return map;
  }
}
