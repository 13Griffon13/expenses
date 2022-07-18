import 'package:finances/model/filter_settings.dart';
import 'package:finances/util/api_keys.dart';
import 'package:finances/model/purchase_category.dart';
import 'package:finances/model/purchase_record.dart';
import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';

class FirebaseServices {
  FirebaseAuth fireAuth = FirebaseAuth(ApiKeys.firebaseWebApi, VolatileStore());
  Firestore fireStore = Firestore(ApiKeys.projectId);
  static const String recordsCollection = "records";
  static const String categoriesCollection = "category";

  Future<void> init() async {
    FirebaseAuth.initialize(ApiKeys.firebaseWebApi, VolatileStore());
    fireAuth = FirebaseAuth.instance;
    Firestore.initialize(ApiKeys.projectId);
    fireStore = Firestore.instance;
  }

  Future<List<Document>> getRecords(FilterSettings settings, String docName) {
    return fireStore
        .collection(fireAuth.userId)
        .document(docName)
        .collection(recordsCollection)
        .where(
          'date',
          isGreaterThanOrEqualTo: settings.from,
          isLessThanOrEqualTo: settings.to,
        )
        .get();
  }

  Stream<List<Document>> recordsStream(String docName) {
    return fireStore
        .collection(fireAuth.userId)
        .document(docName)
        .collection(recordsCollection)
        .stream;
  }

  Stream<List<Document>> categoriesStream() {
    return fireStore
        .collection(fireAuth.userId)
        .document(categoriesCollection)
        .collection(categoriesCollection)
        .stream;
  }

  Future saveRecord(PurchaseRecord record, String docName) {
    return fireStore
        .collection(fireAuth.userId)
        .document(docName)
        .collection(recordsCollection)
        .document(record.id)
        .create(record.toFirebaseMap());
  }

  Future editRecord(PurchaseRecord record, String docName) {
    return fireStore
        .collection(fireAuth.userId)
        .document(docName)
        .collection(recordsCollection)
        .document(record.id)
        .update(record.toFirebaseMap());
  }

  Future saveCategory(PurchaseCategory category) {
    return fireStore
        .collection(fireAuth.userId)
        .document(categoriesCollection)
        .collection(categoriesCollection)
        .document(category.id)
        .create(category.toMap());
  }

  Future deleteRecord(PurchaseRecord record, String docName) {
    return fireStore
        .collection(fireAuth.userId)
        .document(docName)
        .collection(recordsCollection)
        .document(record.id)
        .delete();
  }

  Future deleteCategory(PurchaseCategory category) {
    return fireStore
        .collection(fireAuth.userId)
        .document(categoriesCollection)
        .collection(categoriesCollection)
        .document(category.id)
        .delete();
  }

  Future<User> signIn(String email, String password) {
    return fireAuth.signIn(email, password);
  }

  Future<User> signUp(String email, String password) {
    return fireAuth.signUp(email, password);
  }

  bool isSignedIn() {
    return fireAuth.isSignedIn;
  }

// Future<void> initCollections() async {
//   bool recordsCheck = await fireStore
//       .collection(firebaseAuth.userId)
//       .document(recordsCollection)
//       .exists;
//   bool categoriesCheck = await fireStore
//       .collection(firebaseAuth.userId)
//       .document(categoriesCollection)
//       .exists;
// }
}
