import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  LocalStorageService(this._secureStorage);

  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  // T readKey<T>(String key, {T? defaultValue}) {
  //   final dynamic value = _sharedPreferences.get(key);

  //   return (value ?? defaultValue) as T;
  // }

  String readString(String key, {String defaultValue = ""}) {
    return _sharedPreferences.getString(key) ?? defaultValue;
  }

  bool readBool(String key, {bool defaultValue = false}) {
    return _sharedPreferences.getBool(key) ?? defaultValue;
  }

  Future<void> writeKey(String key, dynamic value) async {
    if (value.runtimeType.toString().toLowerCase() == 'bool') {
      await _sharedPreferences.setBool(key, value as bool);
    } else {
      await _sharedPreferences.setString(key, value as String);
    }
  }

  Future<void> writeSecureKey(String key, String value) async {
    try {
      if (<String>['null', ''].contains(value)) {
        throw '$key is empty';
      }
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeSession() async {
    await removeAllSecureKeys();
    await removeAllKeysInSharedPreferences();
    writeKey(appInstalled, true);
  }

  Future<String?> readSecureKey(String key, {String? defaultValue}) async {
    return await _secureStorage.read(key: key) ?? defaultValue;
  }

  Future<void> removeKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  Future<void> removeAllSecureKeys() async {
    await _secureStorage.deleteAll();
  }

  Future<void> removeAllKeysInSharedPreferences() async {
    (await SharedPreferences.getInstance()).clear();
  }

  ///contain key
  Future<bool> containKey(String key) async {
    return (await SharedPreferences.getInstance()).containsKey(key);
  }

  Future<bool> containSecureKey(String key) async {
    final bool contain = await _secureStorage.containsKey(key: key);
    return contain;
  }

  /// setters and getters
  ///-----setters
  Future<void> setUserToken(String token) async {
    await writeSecureKey(userToken, token);
    loggedInUser.token = token;
  }

  Future<void> setUserUUID(String uuid) async {
    await writeSecureKey(userUUID, uuid);
    loggedInUser.uuid = uuid;
  }

  Future<void> setUserPhone(String phone) async {
    await writeSecureKey(userPhone, phone);
    loggedInUser.phone = phone;
  }

  Future<void> setUserPinCode(String pinCode) async {
    await writeSecureKey(userPinCode, pinCode);
    loggedInUser.pinCode = pinCode;
  }

  Future<void> setTouchIdValue({required bool touchId}) async {
    await writeKey(userTouchId, touchId);
    loggedInUser.isTouchIdActive = touchId;
  }

  Future<void> setUsername(String name) async {
    await writeKey(userName, name);
    loggedInUser.name = name;
  }

  Future<void> setFaceIdValue({required bool faceId}) async {
    await writeKey(userFaceId, faceId);
    loggedInUser.isFaceIdActive = faceId;
  }

  Future<void> setUserCountry({required String country}) async {
    await writeSecureKey(userCountry, country);
    loggedInUser.country = country;
  }

  Future<void> setUserCurrency({required String currency}) async {
    await writeSecureKey(userCurrency, currency);
    loggedInUser.currency = currency;
  }

  Future<void> setUserId(String id) async {
    await writeSecureKey(userId, id);
    loggedInUser.identityId = id;
  }

  ///---- getters
  Future<String?> get getUserToken => readSecureKey(userToken);

  Future<String?> get getUserCountry => readSecureKey(userCountry);

  Future<String?> get getUserCurrency => readSecureKey(userCurrency);

  Future<String?> get getUserUUID => readSecureKey(userUUID);

  Future<String?> get getUserPhone => readSecureKey(userPhone);

  Future<String?> get getUserPinCode => readSecureKey(userPinCode);

  Future<String?> get getUserId => readSecureKey(userId);

  bool get getUserTouchId => readBool(userTouchId);

  bool get getUserFaceId => readBool(userFaceId);

  String? get getUserName => readString(userName);

  Future<void> cacheCurrentUser(LoggedInUser user) async {
    await setUserId(user.identityId.toString());
    await setUsername(user.name.toString());
    await setUserToken(user.token.toString());
    await setUserUUID(user.uuid.toString());
    await setUserPhone(user.phone.toString());
    await setUserPinCode(user.pinCode.toString());
    await setUserCountry(country: user.country.toString());
    await setUserCurrency(currency: user.currency.toString());
    await setTouchIdValue(touchId: user.isTouchIdActive ?? false);
    await setFaceIdValue(faceId: user.isFaceIdActive ?? false);
  }
}
