import 'dart:math';

class RandomHelper {
  /// returns Set in length of [amount] of non-negative random integers uniformly distributed in the range
  /// from 0, inclusive, to [max], exclusive.
  /// [amount] should be <= [max].
  /// [max] should be greater then 0.
  Set<int> getSetOfRandNumbers({required int amount, required int max}) {
    assert(max > 0);
    assert(amount <= max);

    final rand = Random();
    final randNumbers = Set<int>();
    while (randNumbers.length < amount) {
      final id = rand.nextInt(max);
      randNumbers.add(id);
    }
    return randNumbers;
  }
}
