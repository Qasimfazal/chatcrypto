// class VigenereCipher {
//
//   // static String generateKey(String str, String key) {
//   //   int x = str.length;
//   //   for (int i = 0;; i++) {
//   //     if (x == i) {
//   //       i = 0;
//   //     }
//   //     if (key.length == str.length) {
//   //       break;
//   //     }
//   //     key += key[i];
//   //   }
//   //   return key;
//   // }
//
//   static String cipherText(String str, String key) {
//     String cipher_text = "";
//     for (int i = 0; i < str.length; i++) {
//       int x = ((str.codeUnitAt(i) + key.codeUnitAt(i)) % 26);
//       x += 'A'.codeUnitAt(0);
//       cipher_text += x.toString();
//     }
//     return cipher_text;
//   }
//
//   static String originalText(String cipher_text, String key) {
//     String orig_text = "";
//     for (int i = 0; (i < cipher_text.length) && (i < key.length); i++) {
//       int x = (((cipher_text.codeUnitAt(i) - key.codeUnitAt(i)) + 26) % 26);
//       x += 'A'.codeUnitAt(0);
//       orig_text += x.toString();
//     }
//     return orig_text;
//   }
// }
//   // static String LowerToUpper(String s)
//   // {
//   //   StringBuffer str = new StringBuffer(s);
//   //   for (int i = 0; i < s.length; i++) {
//   //     if (Character.isLowerCase(s.codeUnitAt(i))) {
//   //       str(i, Character.toUpperCase(s.codeUnitAt(i)));
//   //     }
//   //   }
//   //   s = str.toString();
//   //   return s;
//   // }
//
