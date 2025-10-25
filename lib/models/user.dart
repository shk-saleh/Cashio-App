import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class UserProfile extends HiveObject {
  @HiveField(0)
  String firstName;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String email;

  @HiveField(3)
  String avatarUrl;

  UserProfile({
    this.firstName = 'Ethan',
    this.lastName = 'Cole',
    this.email = 'ethancoleux@gmail.com',
    this.avatarUrl =
    'https://www.pngplay.com/wp-content/uploads/12/User-Avatar-Profile-No-Background.png',
  });

  String get fullName => '$firstName $lastName';
}
