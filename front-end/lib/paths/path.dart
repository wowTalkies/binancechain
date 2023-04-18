import 'package:firebase_database/firebase_database.dart';

var app = FirebaseDatabase.instance;
class Paths{
  final master = app.ref("Master") ;
}
