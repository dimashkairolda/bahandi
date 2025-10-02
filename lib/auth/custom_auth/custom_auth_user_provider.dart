import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class BahandiAuthUser {
  BahandiAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<BahandiAuthUser> bahandiAuthUserSubject =
    BehaviorSubject.seeded(BahandiAuthUser(loggedIn: false));
Stream<BahandiAuthUser> bahandiAuthUserStream() => bahandiAuthUserSubject
    .asBroadcastStream()
    .map((user) => currentUser = user);
