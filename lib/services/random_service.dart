import 'dart:math';

class RandomService {
  final _rand = Random(DateTime.now().millisecondsSinceEpoch);

  /// returns Set in length of [amount] of non-negative random integers uniformly distributed in the range
  /// from 0, inclusive, to [max], exclusive.
  /// [amount] should be <= [max].
  /// [max] should be greater then 0.
  Set<int> getSetOfRandNumbers({required int amount, required int max}) {
    assert(max > 0);
    assert(amount <= max);

    final randNumbers = Set<int>();
    while (randNumbers.length < amount) {
      final id = _rand.nextInt(max);
      randNumbers.add(id);
    }
    return randNumbers;
  }
}
