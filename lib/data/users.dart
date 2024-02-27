import '../generated/assets.dart';
import '../models/user.dart';

class Users {
  static List<User> data = [
    User(
      image: Assets.assetsProfile,
      userName: 'Jessie J',
      userEmail: 'jessy@gmail.com',
    ),
    User(
      image: Assets.assetsNopic,
      userName: 'Andrea R.',
      userEmail: 'andrea@gmail.com',
    ),
  ];
}
