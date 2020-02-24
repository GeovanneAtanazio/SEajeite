abstract class ILocalStorage {
  Future<bool> delete(String key);
  Future<String> getString(String key);
  Future<List<String>> getStringList(String key);
  Future<bool> putString(String key, String value);
  Future<bool> putStringList(String key, List<String> value);
}
