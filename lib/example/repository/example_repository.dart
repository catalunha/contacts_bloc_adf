class ExampleRepository {
  Future<List<String>> getNames() async {
    List<String> names = ['aaa', 'bbb', 'ccc'];
    await Future.delayed(const Duration(seconds: 2));
    return names;
  }
}
