class Suspects {
  String name;
  String nickname;
  String gender;
  int bounty;
  String crime;
  String status;
  String suspectDescription;
  String suspectImage;
  String lastSeenLocation;

  Suspects ({
    required this.name,
    required this.nickname,
    required this.gender,
    required this.bounty,
    required this.crime,
    required this.status,
    required this.suspectDescription,
    required this.suspectImage,
    required this.lastSeenLocation,

  });

  factory Suspects.fromJSON(Map<String, dynamic> json) {
    return Suspects(
      name: json['name'],
      nickname: json['nickname'],
      gender: json['gender'],
      bounty: json['bounty'],
      crime: json['crime'],
      status: json['status'],
      suspectDescription: json['suspect_description'],
      suspectImage: json['suspect_img'],
      lastSeenLocation: json['last_seen_location']
    );
  }
}