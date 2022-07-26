import 'package:firedart/firedart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService extends TokenStore{

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final String itemKey;

  SecureStorageService({required this.itemKey});

  @override
  void delete() {
    _secureStorage.delete(key: itemKey,);
  }

  @override
  Token? read() {
    try{
      _secureStorage.read(key: itemKey);

    }catch(exception){
      throw exception;
    }
  }

  @override
  void write(Token? token) {
    _secureStorage.write(key: itemKey, value: token.toString());
  }

}