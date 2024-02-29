import 'package:dh_cache_manager/interactor/keys/auth_keys/auth_keys.dart';

class EmailTokenKey implements CacheKey {
  @override
  String get key => "email";
}

class NameTokenKey implements CacheKey {
  @override
  String get key => "name";
}

class RoleTokenKey implements CacheKey {
  @override
  String get key => "role";
}
