import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class User {
  const User(this.id, this.firstName, this.lastName, this.userName, this.avatarUrl, this.beers, this.emptySince);

  /// User details
  final num id;
  final String firstName;
  final String lastName;
  String get initials => firstName[0] + lastName[0];
  final String userName;
  final String avatarUrl;

  /// Beer details
  final num beers;
  // If out of beers -> time is set
  final DateTime? emptySince;
}

// class UserNotifier extends StateNotifier<User> {
//   UserNotifier(): super(User());
// }