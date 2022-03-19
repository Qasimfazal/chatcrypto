import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Services/Model.dart';

String Result ;
String Result2 ;
String Result3 ;
String ResultD ;
String ResultD2 ;
String ResultDecryptFinal ;
String Final;
int Randomkey ;

String SignUpKuConverted;
String Ku;
String name;
List<UsersData> FetchedUsersData = [];
List<String> Uids = [];
String NAME,ID,EMA;
// Future<void>FetchusersData()async{
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final FirebaseUser user = await auth.currentUser();
//   final uid = user.uid;
//   Future getDocs() async {
//     QuerySnapshot querySnapshot = await Firestore.instance.collection("Users").getDocuments();
//     for (int i = 0; i < querySnapshot.documents.length; i++) {
//       var a = querySnapshot.documents[i];
//       print(a.documentID);
//
//     }
//   }
//     for(int res = 0; res < FetchedUsersData.length; res++){
//       await Firestore.instance.document('Users').get().then((DocumentSnapshot document) {
//
//         FetchedUsersData.add(UsersData(
//         Uid: document.data[uid] ,
//         Name: document.data['Name'],
//         Email: document.data['email'],
//         Ku: document.data['Ku'],
//       ));
//       });
//     }
//
// }

Future getDocs() async {
  QuerySnapshot querySnapshot = await Firestore.instance.collectionGroup("Peoples").reference().getDocuments();
  var a = querySnapshot.documents;
  Uid: querySnapshot.documents.toString();
  Name: querySnapshot.documents.toString();
  //Name: document.data['Name'],
  Email:querySnapshot.documents.toString();
  Ku:querySnapshot.documents.toString();
  for (int i = 0; i < querySnapshot.documents.length; i++) {
    var a = querySnapshot.documents[i];
    print(a.documentID);
    FetchedUsersData.add(UsersData(
      Uid: querySnapshot.documents[i].toString(),
      Name: querySnapshot.documents[i].toString(),
      //Name: document.data['Name'],
      Email:querySnapshot.documents[i].toString(),
      Ku:querySnapshot.documents[i].toString(),
    ));

  }

}
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

String myUsername = '';
String myEmail = '';
String myKu = '';
String UID ;
Future<void>GetRing(String Uid)async{
   await _firebaseAuth.currentUser;
   Firestore.instance.collectionGroup("Peoples").reference().document("Users").collection(Uid)
        .snapshots()
        .listen((userData) {

        myUsername = userData.documents[0]['Name'];
        myEmail = userData.documents[0]['email'];
        myKu = userData.documents[0]['Ku'];

      });
    }

