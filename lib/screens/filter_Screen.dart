import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/filter_provider.dart';
import '../providers/training_provider.dart';

class FilterModal extends StatefulWidget {
  final Map<String, List<String>> data;

  const FilterModal({super.key, required this.data});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  String selectedCategory = 'Location';

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Sort and Filters",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: [
                    // Left Side Menu
                    Container(
                      width: 150,
                      color: Colors.grey[200],
                      child: ListView(
                        children: widget.data.keys.map((category) {
                          return ListTile(
                            title: Text(
                              category,
                              style: TextStyle(
                                fontWeight: selectedCategory == category
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectedCategory == category
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            /*tileColor: selectedCategory == category
                                ? Colors.red
                                : Colors.white,
                            selectedTileColor: Colors.red,*/
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    // Right Side Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedCategory,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView(
                                children:
                                    widget.data[selectedCategory]!.map((item) {
                                  return CheckboxListTile(
                                    activeColor: Colors.red,
                                    //selectedTileColor: Colors.red,
                                    title: Text(item),
                                    value: selectedCategory == "Location"
                                        ? filterProvider.selectedLocations
                                            .contains(item)
                                        : selectedCategory == "Training Name"
                                            ? filterProvider.selectedTrainingNames
                                                .contains(item)
                                            : filterProvider.selectedTrainers
                                                .contains(item),
                                    onChanged: (selected) {
                                      setState(() {
                                        if (selectedCategory == "Location") {
                                          final updatedLocations =
                                              List<String>.from(
                                                  filterProvider.selectedLocations);
                                          selected == true
                                              ? updatedLocations.add(item)
                                              : updatedLocations.remove(item);
                                          filterProvider.setSelectedLocations(
                                              updatedLocations);
                                        } else if (selectedCategory ==
                                            "Training Name") {
                                          final updatedTrainingNames =
                                              List<String>.from(filterProvider
                                                  .selectedTrainingNames);
                                          selected == true
                                              ? updatedTrainingNames.add(item)
                                              : updatedTrainingNames.remove(item);
                                          filterProvider.setSelectedTrainingNames(
                                              updatedTrainingNames);
                                        } else {
                                          final updatedTrainers = List<String>.from(
                                              filterProvider.selectedTrainers);
                                          selected == true
                                              ? updatedTrainers.add(item)
                                              : updatedTrainers.remove(item);
                                          filterProvider
                                              .setSelectedTrainers(updatedTrainers);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      filterProvider.clearFilters();
                      Provider.of<TrainingProvider>(context, listen: false)
                          .resetTrainings();
                      Provider.of<TrainingProvider>(context, listen: false)
                          .loadTrainings();
                      Navigator.pop(context);
                    },
                    child: const Text("Clear Filters",style: TextStyle(
                    color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                    ),),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Provider.of<TrainingProvider>(context, listen: false)
                          .resetTrainings();
                      Provider.of<TrainingProvider>(context, listen: false)
                          .loadTrainings(
                        locations: filterProvider.selectedLocations,
                        trainingNames: filterProvider.selectedTrainingNames,
                        trainers: filterProvider.selectedTrainers,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Apply",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Close the screen
              },
            ),
          ),
        ],
      ),
    );
  }
}
