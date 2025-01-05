import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainings_app/screens/training_details_screen.dart';
import 'package:trainings_app/screens/training_view.dart';

import '../providers/filter_provider.dart';
import '../providers/training_provider.dart';
import 'filter_Screen.dart';

class TrainingHomeScreen extends StatefulWidget {
  const TrainingHomeScreen({super.key});

  @override
  TrainingHomeScreenState createState() => TrainingHomeScreenState();
}

class TrainingHomeScreenState extends State<TrainingHomeScreen> {
  late ScrollController _scrollController;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TrainingProvider>(context, listen: false).loadTrainings(isDelay: false);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final filterProvider = Provider.of<FilterProvider>(context, listen: false);
      Provider.of<TrainingProvider>(context, listen: false).loadTrainings(
        locations: filterProvider.selectedLocations,
        trainingNames: filterProvider.selectedTrainingNames,
        trainers: filterProvider.selectedTrainers,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar:AppBar(
        elevation: 0,
        title: const Text('Training Home'),
      ),*/
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *
                0.25,
            color: Colors.red[900],
          ),
          Consumer<TrainingProvider>(
            builder: (context, trainingProvider, _) {
              final trainings = trainingProvider.trainings;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    elevation: 0,
                    title: const Text('Training Home',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal:16, vertical: 8.0),
                    child: Text('Highlight',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),),
                  ),
                  // Highlight Carousel
                  Stack(
                    children: [
                      CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.9,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: trainings.map((highlight) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrainingDetailsScreen(
                                    training: highlight,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(1),
                                    child: Image.network(
                                      "https://fakeimg.pl/350x200/ff0000,128/000,255",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.black87,
                                          Colors.transparent
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          highlight["title"]!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${highlight["location"]!} - ${highlight["date"]!}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text.rich(
                                          TextSpan(
                                            text: highlight["price"]!,
                                            // Original price with strikethrough
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.red[900],
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: " ",
                                              ),
                                              TextSpan(
                                                text: highlight[
                                                    "discountedPrice"]!,
                                                // Discounted price
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red[900],
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 16,
                                    right: 16,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "View Details",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // Left Arrow
                      Positioned(
                        top: 50,
                        bottom: 50,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            gradient: const LinearGradient(
                              colors: [Colors.black87, Colors.black54],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () {
                              _carouselController.previousPage();
                            },
                          ),
                        ),
                      ),
                      // Right Arrow
                      Positioned(
                        top: 50,
                        bottom: 50,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1),
                            gradient: const LinearGradient(
                              colors: [Colors.black87, Colors.black54],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                            onPressed: () {
                              _carouselController.nextPage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Filter Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(72, 40),
                        backgroundColor: Colors.white,
                        // Button background color
                        side: const BorderSide(color: Colors.grey, width: 1),
                        // Border color and width
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(4), // Rounded corners
                        ),
                      ),
                      /*style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),*/
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) {
                            return const FilterModal(
                              data: {
                                //"West Des Moines", "Chicago, IL", "Phoenix, AZ", "Dallas, TX", "San Diego, CA"
                                'Location': [
                                  'West Des Moines',
                                  'Chicago, IL',
                                  'Phoenix, AZ',
                                  'Dallas, TX',
                                  'San Diego, CA',
                                  'San Francisco, CA',
                                  'New York, ZK',
                                ],
                                //"Safe Scrum Master (4.0)", "Safe Scrum Master (4.1)", "Safe Scrum Master (4.2)"
                                'Training Name': [
                                  'Safe Scrum Master (4.0)',
                                  'Safe Scrum Master (4.1)',
                                  'Safe Scrum Master (4.2)',
                                ],
                                //"Helen Gribble", "John Doe", "Jane Smith", "Sarah Johnson"
                                'Trainer': [
                                  'Helen Gribble',
                                  'John Doe',
                                  'Jane Smith',
                                  'Sarah Johnson',
                                ],
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.filter_list, size: 20, color: Colors.black54,),
                      label: const Text('Filter',style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          trainings.length + (trainingProvider.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == trainings.length) {
                          return Center(
                              child: CircularProgressIndicator(color: Colors.red[900],));
                        }
                        final training = trainings[index];
                        return TrainingView(training: training);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
