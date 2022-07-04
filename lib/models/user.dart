class AppUser {
  AppUser(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.role,
      required this.level,
      required this.profilePicUrl,
      required this.address});
  late final String id;

  late final String fullName;
  late final String email;
  late final String role;
  late final int level;
  late final String profilePicUrl;
  late final String address;

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    level = json['level'];
    profilePicUrl = json['profilePicUrl'] ?? '';
    address = json['address'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['fullName'] = fullName;
    _data['email'] = email;
    _data['role'] = role;
    _data['level'] = level;
    _data['profilePicUrl'] = profilePicUrl;
    _data['address'] = address;
    return _data;
  }
}
