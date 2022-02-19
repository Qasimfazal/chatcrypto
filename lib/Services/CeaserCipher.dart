

import '../Result.dart';

class Ceaser {
  //static String _result = "";
  static void process(bool _isEncrypt,text,key) {
    //String _text = '_wordController.text';

    String _temp = "";

    // try {
    //   _key = int.parse(_keyController.text);
    // } catch (e) {
    //   _showAlert("Invalid Key");
    // }

    for (int i = 0; i < text.length; i++) {
      int ch = text.codeUnitAt(i);
      int offset;
      String h;
      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch == ' '.codeUnitAt(0)) {
        _temp += " ";
        continue;
      } else {
        print("Invalid Text");
        _temp = "";
        break;
      }

      int c;
      if (_isEncrypt) {
        c = (ch + key - offset) % 26;
      } else {
        c = (ch - key - offset) % 26;
      }
      h = String.fromCharCode(c + offset);
      _temp += h;
    }


    Result = _temp;

  }

}