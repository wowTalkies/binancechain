import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

var app = FirebaseDatabase.instance;
var userId = FirebaseAuth.instance.currentUser?.uid ?? '';
var user = FirebaseAuth.instance.currentUser ?? '';

class Paths {
  final currrentUser = user ?? '';
  final uId = userId ?? '';
  final master = app.ref("Master");
  final profile = app.ref("Master").child("Profile");
  final address = app.ref("Master").child("Address");
  final node = app.ref("Master").child("Profile").child("node");
}
