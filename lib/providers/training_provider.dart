import 'package:flutter/material.dart';

class TrainingProvider with ChangeNotifier {
  final List<Map<String, String>> _trainings = [];
  bool _isLoading = false;
  bool _hasMore = true;

  final List<Map<String, String>> _allTrainings = List.generate(100, (index) {
    return {
      "name": "Training ${index + 1}",
      'title': [
        "Safe Scrum Master (4.0)",
        "Safe Scrum Master (4.1)",
        "Safe Scrum Master (4.2)"
      ][index % 3],
      "trainer": [
        "Helen Gribble",
        "John Doe",
        "Jane Smith",
        "Sarah Johnson"
      ][index % 4],
      "location": [
        "West Des Moines",
        "Chicago, IL",
        "Phoenix, AZ",
        "Dallas, TX",
        "San Diego, CA",
        "San Francisco, CA",
        "New York, ZK"
      ][index % 7],
      'date': [
        "Jan 05 - 10, 2025",
        "Jan 10 - 15, 2025",
        "Jan 15 - 20, 2025"
      ][index % 3],
      'time': [
        "08:30 am - 12:30 pm",
        "01:30 pm - 05:30 pm",
        "06:30 pm - 10:30 pm"
      ][index % 3],
      'price': ["\$500", "\$600", "\$800"][index % 3],
      'discountedPrice': ["\$449", "\$549", "\$749"][index % 3],
    };
  });

  int _currentPage = 0;
  final int _pageSize = 20;

  List<Map<String, String>> get trainings => _trainings;

  bool get isLoading => _isLoading;

  bool get hasMore => _hasMore;

  void loadTrainings({
    bool isDelay = true,
    List<String>? locations,
    List<String>? trainingNames,
    List<String>? trainers,
  }) async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    if(isDelay) await Future.delayed(const Duration(seconds: 2));

    final filteredTrainings = _allTrainings.where((training) {
      final matchesLocation = locations == null ||
          locations.isEmpty ||
          locations.contains(training["location"]);
      final matchesTrainingName = trainingNames == null ||
          trainingNames.isEmpty ||
          trainingNames.contains(training["title"]);
      final matchesTrainer = trainers == null ||
          trainers.isEmpty ||
          trainers.contains(training["trainer"]);
      return matchesLocation && matchesTrainingName && matchesTrainer;
    }).toList();

    int start = _currentPage * _pageSize;
    int end = start + _pageSize;

    if (start >= filteredTrainings.length) {
      _hasMore = false;
    } else {
      _trainings.addAll(filteredTrainings.sublist(
          start, end.clamp(0, filteredTrainings.length)));
      _currentPage++;
    }

    _isLoading = false;
    notifyListeners();
  }

  void resetTrainings() {
    _trainings.clear();
    _currentPage = 0;
    _hasMore = true;
    notifyListeners();
  }
}
