class Suspects {
  String id;
  String name;
  String nickname;
  String gender;
  String bounty;
  String crime;
  String status;
  String suspectDescription;
  String suspectImage;
  String lastSeenLocation;

  Suspects ({
    required this.id,
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
      id: json['id'],
      name: json['name'],
      nickname: json['nickname'],
      gender: json['gender'],
      bounty: json['bounty'],
      crime: json['crime'],
      status: json['status'],
      suspectDescription: json['suspect_description'],
      suspectImage: json['suspect_image'],
      lastSeenLocation: json['last_seen_location']
    );
  }
}