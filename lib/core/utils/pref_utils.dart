
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  /// Sets the user's authentication token
  Future<void> setAuthToken(String token) {return _sharedPreferences!.setString('authToken', token);}
  String getAuthToken() {try {return _sharedPreferences!.getString('authToken')!;} catch (e) {return '';}}



  /// Sets the user ID
  Future<void> setUserId(String userId) {return _sharedPreferences!.setString('userId', userId);}
  String getUserId() {try {return _sharedPreferences!.getString('userId')!;} catch (e) {return '';}}


  Future<void> setUserCountry(String userId) {return _sharedPreferences!.setString('userCountry', userId);}
  String getUserCountry() {try {return _sharedPreferences!.getString('userCountry')!;} catch (e) {return '';}}


  Future<void> setUserCity(String userId) {return _sharedPreferences!.setString('userCity', userId);}
  String getUserCity() {try {return _sharedPreferences!.getString('userCity')!;} catch (e) {return '';}}





  /// Checks if the user is logged in
  bool isLoggedIn() {String token = getAuthToken();return token.isNotEmpty;}
  void logout() {clearPreferencesData();}




  /// Checks if the user is logged in


  Future<void> setUserFirstName(String firstName) {return _sharedPreferences!.setString('userFirstName', firstName);}
  String getUserFirstName() {try {return _sharedPreferences!.getString('userFirstName')!;} catch (e) {return '';}}

  /// Sets the user's last name
  Future<void> setUserLastName(String lastName) {return _sharedPreferences!.setString('userLastName', lastName);}
  String getUserLastName() {try {return _sharedPreferences!.getString('userLastName')!;} catch (e) {return '';}}

  /// Sets the user's profile URL
  Future<void> setUserProfileUrl(String profileUrl) {return _sharedPreferences!.setString('userProfileUrl', profileUrl);}
  String getUserProfileUrl() {try {return _sharedPreferences!.getString('userProfileUrl')!;} catch (e) {return '';}}


  /// Sets the user's profile URL

  Future<void> setUserCoverUrl(String profileUrl) {return _sharedPreferences!.setString('userCoverUrl', profileUrl);}
  String getUserCoverUrl() {try {return _sharedPreferences!.getString('userProfileUrl')!;} catch (e) {return '';}}







  void clearPreferencesData() async {_sharedPreferences!.clear();}






  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }












  /// Sets the theme data
  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  /// Gets the theme data
  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }
}
