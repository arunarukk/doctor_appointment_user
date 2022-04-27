import 'dart:convert';

class Schedule {
  DateTime date;
  bool nineAm;
  bool tenAm;
  bool elevenAm;
  bool twelvePm;
  bool onepm;
  bool twoPm;
  bool threePm;
  bool fourPm;
  bool fivePm;
  bool sixPm;

  Schedule({
    required this.date,
    this.nineAm = false,
    this.tenAm = false,
    this.elevenAm = false,
    this.twelvePm = false,
    this.onepm = false,
    this.twoPm = false,
    this.threePm = false,
    this.fourPm = false,
    this.fivePm = false,
    this.sixPm = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'nineAm': nineAm,
      'tenAm': tenAm,
      'elevenAm': elevenAm,
      'twelvePm': twelvePm,
      'onepm': onepm,
      'twoPm': twoPm,
      'threePm': threePm,
      'fourPm': fourPm,
      'fivePm': fivePm,
      'sixPm': sixPm,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      nineAm: map['nineAm'] ?? false,
      tenAm: map['tenAm'] ?? false,
      elevenAm: map['elevenAm'] ?? false,
      twelvePm: map['twelvePm'] ?? false,
      onepm: map['onepm'] ?? false,
      twoPm: map['twoPm'] ?? false,
      threePm: map['threePm'] ?? false,
      fourPm: map['fourPm'] ?? false,
      fivePm: map['fivePm'] ?? false,
      sixPm: map['sixPm'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source));

  Schedule copyWith({
    DateTime? date,
    bool? nineAm,
    bool? tenAm,
    bool? elevenAm,
    bool? twelvePm,
    bool? onepm,
    bool? twoPm,
    bool? threePm,
    bool? fourPm,
    bool? fivePm,
    bool? sixPm,
  }) {
    return Schedule(
      date: date ?? this.date,
      nineAm: nineAm ?? this.nineAm,
      tenAm: tenAm ?? this.tenAm,
      elevenAm: elevenAm ?? this.elevenAm,
      twelvePm: twelvePm ?? this.twelvePm,
      onepm: onepm ?? this.onepm,
      twoPm: twoPm ?? this.twoPm,
      threePm: threePm ?? this.threePm,
      fourPm: fourPm ?? this.fourPm,
      fivePm: fivePm ?? this.fivePm,
      sixPm: sixPm ?? this.sixPm,
    );
  }
}
