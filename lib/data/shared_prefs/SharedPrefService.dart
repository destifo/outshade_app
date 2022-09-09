import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {

  void removeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
  }

  void removeAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('age');
  }

  void removeGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('gender');
  }

  void setLoggedinState(String state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loggedinState', state);
  }

  Future<String?> getLoggedinState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('loggedinState');
  }

  void setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  void setAge(double age) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('age', age);
  }

  Future<double?> getAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('age');
  }

  void setGender(String gender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gender', gender);
  }

  Future<String?> getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('gender');
  }

}
