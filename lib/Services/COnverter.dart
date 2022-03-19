

import '../Result.dart';

class SignUpConverter{
  static void Converter(bool _isEncrypt,text,key) {

    String _temp = "";

    for (int i = 0; i < text.length; i++) {
      int ch = text.codeUnitAt(i);
      int offset;
      String h;
      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 49;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch >= '1'.codeUnitAt(0) && ch <= '9'.codeUnitAt(0) ) {
        offset = 65;
        //   // _temp += " ";
        //  continue;
      } else if (ch == ' '.codeUnitAt(0)) {
        _temp += " ";
        continue;
      } else{
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
      //  ResultD = _temp;
    }


    SignUpKuConverted = _temp;

  }

}