List<({String word, int frequency})> findWordFrequencies(String sentence) {
  if (sentence.trim().isEmpty) {
    return [];
  }

  // Remove punctuation and split into words.
  final words = sentence
      .toLowerCase()
      .split(RegExp(r'[^\p{L}\p{N}]+', unicode: true)) // Split by non-alphanumeric/non-letter characters
      .where((word) => word.isNotEmpty)
      .toList();

  if (words.isEmpty) {
    return [];
  }

  final wordFrequencies = <String, int>{};
  for (final word in words) {
    wordFrequencies.update(word, (value) => value + 1, ifAbsent: () => 1);
  }

  // Convert the map to a list of records for easier processing if needed,
  // or return the map directly if the consumer needs all frequencies.
  // For now, we'll return a list of records, which will be filtered later for most frequent.
  return wordFrequencies.entries
      .map((entry) => (word: entry.key, frequency: entry.value))
      .toList();
}

({int frequency, List<String> words}) findMostFrequentWordsAndFrequency(String sentence) {
  final allWordFrequencies = findWordFrequencies(sentence);

  if (allWordFrequencies.isEmpty) {
    return (frequency: 0, words: []);
  }

  int maxFrequency = 0;
  for (final entry in allWordFrequencies) {
    if (entry.frequency > maxFrequency) {
      maxFrequency = entry.frequency;
    }
  }

  final mostFrequentWords = <String>[];
  for (final entry in allWordFrequencies) {
    if (entry.frequency == maxFrequency) {
      mostFrequentWords.add(entry.word);
    }
  }

  // Sort the words for consistent output.
  mostFrequentWords.sort();

  return (frequency: maxFrequency, words: mostFrequentWords);
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
    final result = findMostFrequentWordsAndFrequency(sentence);

    if (result.words.isNotEmpty) {
      print("${result.words} (frequency: ${result.frequency}) (appears in line #$lineNum)");
    } else {
      print("[] (no valid words found in line #$lineNum)");
    }
  }
}
