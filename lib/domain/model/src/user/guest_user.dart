import 'user.dart';

const guestUser = const GuestUser();

class GuestUser implements User {
  final String id = 'guest';
  final String name = 'guest';

  const GuestUser();
}
