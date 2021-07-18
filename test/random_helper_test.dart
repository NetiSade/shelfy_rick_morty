import 'package:shelfy/services/random_service.dart';
import 'package:test/test.dart';

void main() {
  group('RandomHelper', () {
    test('length should be 2', () {
      final rand = RandomService();
      final res = rand.getSetOfRandNumbers(max: 2, amount: 2);
      expect(res.length, 2);
    });

    test('length should be 0', () {
      final rand = RandomService();
      final res = rand.getSetOfRandNumbers(max: 2, amount: 0);
      expect(res.length, 0);
    });

    test('numbers in the range from 0, inclusive, to 100, exclusive.', () {
      final rand = RandomService();
      final max = 100;
      final amount = 100;
      final res = rand.getSetOfRandNumbers(max: max, amount: amount);
      expect(res.any((i) => i < 0 || i >= max), false);
    });
  });
}
