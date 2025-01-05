import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  List<String> selectedLocations = [];
  List<String> selectedTrainingNames = [];
  List<String> selectedTrainers = [];

  void setSelectedLocations(List<String> locations) {
    selectedLocations = locations;
    notifyListeners();
  }

  void setSelectedTrainingNames(List<String> trainingNames) {
    selectedTrainingNames = trainingNames;
    notifyListeners();
  }

  void setSelectedTrainers(List<String> trainers) {
    selectedTrainers = trainers;
    notifyListeners();
  }

  void clearFilters() {
    selectedLocations = [];
    selectedTrainingNames = [];
    selectedTrainers = [];
    notifyListeners();
  }
}
