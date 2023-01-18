// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/firestore.dart';

// abstract class FirestoreApi<T extends FirestoreEntry> {
//   // reference to main database
//   final CollectionReference<T> ref;

//   // FirestoreApi(String collection,
//   //     Entry Function(DocumentSnapshot<Map<String, dynamic>>) constructor)
//   //     : ref = FirebaseFirestore.instance
//   //           .collection(collection)
//   //           .withConverter<Entry>(
//   //               fromFirestore: (doc, _) => constructor(doc),
//   //               toFirestore: (entry, _) => entry.toMap());

//   FirestoreApi(String collection,
//       T Function(DocumentSnapshot<Map<String, dynamic>>) constructor)
//       : ref = FirestoreApi.collectionReference<T>(collection, constructor);

//   static CollectionReference<T> collectionReference<T extends FirestoreEntry>(
//           String collection,
//           T Function(DocumentSnapshot<Map<String, dynamic>>) constructor) =>
//       FirebaseFirestore.instance.collection(collection).withConverter<T>(
//           fromFirestore: (doc, _) => constructor(doc),
//           toFirestore: (entry, _) => entry.toMap());

//   // add an entry to the database
//   Future add(T e) => ref.add(e);

//   // update field fld of doc id with value val
//   Future updateField(String id, dynamic val, String fld) =>
//       ref.doc(id).update({fld: val});
// }
