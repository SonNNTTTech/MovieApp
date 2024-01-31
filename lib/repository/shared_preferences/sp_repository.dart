// ignore_for_file: constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final spRepoProvider = Provider(SpRepository.new);

class SpRepository {
  // ignore: unused_field
  final Ref _ref;
  SpRepository(this._ref);

  static const REQUEST_TOKEN = 'REQUEST_TOKEN';
  static const SESSION_ID = 'SESSION_ID';
  static const GUEST_SESSION_ID = 'GUEST_SESSION_ID';
  static const ACCOUNT_ID = 'ACCOUNT_ID';

  Future setRequestToken(String requestToken) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(REQUEST_TOKEN, requestToken);
  }

  Future<String?> getRequestToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(REQUEST_TOKEN);
  }

  Future deleteRequestToken() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(REQUEST_TOKEN);
  }

  Future setSessionId(String sessionId) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(SESSION_ID, sessionId);
  }

  Future<String?> getSessionId() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(SESSION_ID);
  }

  Future setGuestSessionId(String guestSessionId) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(GUEST_SESSION_ID, guestSessionId);
  }

  Future<String?> getGuestSessionId() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(GUEST_SESSION_ID);
  }

  Future setAccountId(int accountId) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(ACCOUNT_ID, accountId);
  }

  Future<int?> getAccountId() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(ACCOUNT_ID);
  }
}
