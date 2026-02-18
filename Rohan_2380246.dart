List<String> findMostFrequentWords(String sentence) {
  if (sentence.trim().isEmpty) {
    return [];
  }

  final words = sentence
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();

  if (words.isEmpty) {
    return [];
  }

  // Use a HashMap to store word frequencies.
  final wordFrequencies = <String, int>{};
  for (final word in words) {
    wordFrequencies.update(word, (value) => value + 1, ifAbsent: () => 1);
  }

  int maxFrequency = 0;
  if (wordFrequencies.isNotEmpty) {
    maxFrequency = wordFrequencies.values.reduce((a, b) => a > b ? a : b);
  }

  final mostFrequentWords = <String>[];
  wordFrequencies.forEach((word, frequency) {
    if (frequency == maxFrequency) {
      mostFrequentWords.add(word);
    }
  });

  // Sort the words for consistent output, though not strictly required by prompt.
  mostFrequentWords.sort();

  return mostFrequentWords;
}

void main() {
  List<String> sentences = [
    "this is a test this is",
    "hello hello world",
    "dart is fun fun fun",
  ];

  print("Finding words with the highest frequency per line:");

  for (int i = 0; i < sentences.length; i++) {
    final sentence = sentences[i];
    final lineNum = i + 1;
    final mostFrequent = findMostFrequentWords(sentence);

    if (mostFrequent.isNotEmpty) {
      print("${mostFrequent} (appears in line #$lineNum)");
    } else {
      print("[] (no valid words found in line #$lineNum)");
    }
  }
}
