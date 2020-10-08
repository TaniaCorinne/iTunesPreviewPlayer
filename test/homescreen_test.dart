import 'package:flutter_test/flutter_test.dart';
import 'package:musicPlayerSearch_flutter/UI/HomeScreen.dart';

void main() {
  test('empty search returns error string', () {
    var result = SearchFieldValidator.validate('');
    expect(result, 'Search field cannot be empty');
  });

  test('non-empty search returns null', () {
    var result = SearchFieldValidator.validate('test');
    expect(result, null);
  });
}
