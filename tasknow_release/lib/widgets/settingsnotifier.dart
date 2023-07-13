import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasknow_release/widgets/homenotifier.dart';

class SettingsNotifier extends ChangeNotifier {
  bool _switchValuedarkmode = false;
  bool _switchValuemesage = false;
  late SharedPreferences _prefs;
    late BuildContext _context;

  bool get switchValuedarkmode => _switchValuedarkmode;
  bool get switchValuemesage => _switchValuemesage;
   
   SettingsNotifier(BuildContext context) {
    _context = context; 
    loadPreferences();
  }
  Future<void> loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _switchValuedarkmode = _prefs.getBool('switchValuedarkmode') ?? false;
    _switchValuemesage = _prefs.getBool('switchValuemesage') ?? false;
    notifyListeners();
    
  }

  void savePreferences() {
    _prefs.setBool('switchValuedarkmode', _switchValuedarkmode);
    _prefs.setBool('switchValuemesage', _switchValuemesage);
  }

  set switchValuedarkmode(bool value) {
    _switchValuedarkmode = value;
    savePreferences();
    notifyListeners();
    if (value == true) {
      Provider.of<HomeNotifier>(_context, listen: false)
          .changeBackgroundColor(const Color.fromARGB(255, 80, 80, 80));
    } else {
      Provider.of<HomeNotifier>(_context, listen: false)
          .changeBackgroundColor(const Color.fromARGB(255, 201, 201, 201));
    }
  }

  set switchValuemesage(bool value) {
    _switchValuemesage = value;
    savePreferences();
    notifyListeners();
  }
}
