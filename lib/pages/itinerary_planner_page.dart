import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:travelapp/models/destination.dart';
import 'package:travelapp/models/itinerary.dart';

class ItineraryPlannerPage extends StatefulWidget {
  const ItineraryPlannerPage({super.key});

  @override
  State<ItineraryPlannerPage> createState() => _ItineraryPlannerPageState();
}

class _ItineraryPlannerPageState extends State<ItineraryPlannerPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  
  // Form data
  String _selectedDestination = '';
  DateTime? _startDate;
  DateTime? _endDate;
  double _budget = 1000;
  List<String> _selectedInterests = [];
  List<DayPlan> _dayPlans = [];

  final List<String> _availableInterests = [
    'Culture & History',
    'Nature & Outdoor',
    'Food & Dining',
    'Adventure Sports',
    'Art & Museums',
    'Nightlife',
    'Shopping',
    'Beaches',
    'Mountains',
    'Photography',
  ];

  final List<Destination> _destinations = [
    Destination(
      id: '1',
      name: 'Tokyo, Japan',
      description: 'Experience the perfect blend of traditional culture and modern innovation.',
      imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400',
      country: 'Japan',
      city: 'Tokyo',
      budgetPerDay: 120.0,
      safetyRating: 9.5,
      activities: ['Temples', 'Shopping', 'Food Tours', 'Museums'],
      highlights: ['Sensoji Temple', 'Tokyo Skytree', 'Shibuya Crossing'],
      bestTimeToVisit: 'Spring (March-May)',
      currency: 'JPY',
      language: 'Japanese',
      averageRating: 4.8,
      reviewCount: 1250,
    ),
    Destination(
      id: '2',
      name: 'Santorini, Greece',
      description: 'Discover the iconic white-washed buildings and stunning sunsets.',
      imageUrl: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=400',
      country: 'Greece',
      city: 'Santorini',
      budgetPerDay: 150.0,
      safetyRating: 8.8,
      activities: ['Beaches', 'Wine Tasting', 'Sunset Views', 'Archaeology'],
      highlights: ['Oia Village', 'Red Beach', 'Ancient Thera'],
      bestTimeToVisit: 'Summer (June-August)',
      currency: 'EUR',
      language: 'Greek',
      averageRating: 4.9,
      reviewCount: 980,
    ),
    Destination(
      id: '3',
      name: 'Reykjavik, Iceland',
      description: 'Explore the land of fire and ice with its dramatic landscapes.',
      imageUrl: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=400',
      country: 'Iceland',
      city: 'Reykjavik',
      budgetPerDay: 200.0,
      safetyRating: 9.2,
      activities: ['Northern Lights', 'Hot Springs', 'Glaciers', 'Whale Watching'],
      highlights: ['Blue Lagoon', 'Golden Circle', 'Hallgrímskirkja'],
      bestTimeToVisit: 'Summer (June-August)',
      currency: 'ISK',
      language: 'Icelandic',
      averageRating: 4.7,
      reviewCount: 750,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Planner'),
        actions: [
          if (_currentStep > 0)
            TextButton(
              onPressed: _previousStep,
              child: const Text('Back'),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                _buildDestinationStep(),
                _buildDateStep(),
                _buildBudgetStep(),
                _buildInterestsStep(),
                _buildItineraryPreview(),
              ],
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: List.generate(5, (index) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4,
              decoration: BoxDecoration(
                color: index <= _currentStep ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDestinationStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Your Destination',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select where you want to travel',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _destinations.length,
              itemBuilder: (context, index) {
                final destination = _destinations[index];
                final isSelected = _selectedDestination == destination.id;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    elevation: isSelected ? 4 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedDestination = destination.id;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                destination.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    destination.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    destination.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.star,
                                        size: 12,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        destination.averageRating.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        '\$${destination.budgetPerDay.toInt()}/day',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const FaIcon(
                                FontAwesomeIcons.checkCircle,
                                color: Colors.blue,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Travel Dates',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your departure and return dates',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          _buildDateSelector(
            'Start Date',
            _startDate,
            (date) {
              setState(() {
                _startDate = date;
                if (_endDate != null && _endDate!.isBefore(date)) {
                  _endDate = null;
                }
              });
            },
          ),
          const SizedBox(height: 24),
          _buildDateSelector(
            'End Date',
            _endDate,
            (date) {
              setState(() {
                _endDate = date;
              });
            },
          ),
          const SizedBox(height: 32),
          if (_startDate != null && _endDate != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.calendar,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Trip Duration: ${_endDate!.difference(_startDate!).inDays + 1} days',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(String label, DateTime? date, Function(DateTime) onDateSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (selectedDate != null) {
              onDateSelected(selectedDate);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.calendar,
                  color: Colors.grey,
                ),
                const SizedBox(width: 12),
                Text(
                  date != null ? DateFormat('MMM dd, yyyy').format(date) : 'Select $label',
                  style: TextStyle(
                    fontSize: 16,
                    color: date != null ? Colors.black : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set Your Budget',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'How much do you want to spend on this trip?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '\$${_budget.toInt()}',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                Slider(
                  value: _budget,
                  min: 500,
                  max: 5000,
                  divisions: 45,
                  onChanged: (value) {
                    setState(() {
                      _budget = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$500',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '\$5,000',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildBudgetBreakdown(),
        ],
      ),
    );
  }

  Widget _buildBudgetBreakdown() {
    final days = _startDate != null && _endDate != null 
        ? _endDate!.difference(_startDate!).inDays + 1 
        : 1;
    final dailyBudget = _budget / days;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Budget Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildBudgetItem('Total Budget', '\$${_budget.toInt()}'),
          _buildBudgetItem('Trip Duration', '$days days'),
          _buildBudgetItem('Daily Budget', '\$${dailyBudget.toInt()}'),
          _buildBudgetItem('Accommodation (40%)', '\$${(_budget * 0.4).toInt()}'),
          _buildBudgetItem('Food & Activities (35%)', '\$${(_budget * 0.35).toInt()}'),
          _buildBudgetItem('Transportation (25%)', '\$${(_budget * 0.25).toInt()}'),
        ],
      ),
    );
  }

  Widget _buildBudgetItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Your Interests',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Help us personalize your itinerary',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _availableInterests.map((interest) {
              final isSelected = _selectedInterests.contains(interest);
              return FilterChip(
                label: Text(interest),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedInterests.add(interest);
                    } else {
                      _selectedInterests.remove(interest);
                    }
                  });
                },
                selectedColor: Colors.blue[100],
                checkmarkColor: Colors.blue,
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          if (_selectedInterests.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Interests:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(_selectedInterests.join(', ')),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItineraryPreview() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Trip Summary',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildSummaryCard(),
          const SizedBox(height: 24),
          const Text(
            'Generated Itinerary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildItineraryDays(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    final destination = _destinations.firstWhere((d) => d.id == _selectedDestination);
    final days = _startDate != null && _endDate != null 
        ? _endDate!.difference(_startDate!).inDays + 1 
        : 1;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    destination.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$days days • \$${_budget.toInt()} budget',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem('Interests', '${_selectedInterests.length}'),
                _buildSummaryItem('Daily Budget', '\$${(_budget / days).toInt()}'),
                _buildSummaryItem('Safety Rating', '${destination.safetyRating}/10'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildItineraryDays() {
    final days = _startDate != null && _endDate != null 
        ? _endDate!.difference(_startDate!).inDays + 1 
        : 1;
    
    return ListView.builder(
      itemCount: days,
      itemBuilder: (context, index) {
        final dayNumber = index + 1;
        final date = _startDate!.add(Duration(days: index));
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Day $dayNumber',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        DateFormat('MMM dd').format(date),
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildActivityItem('Morning', 'Explore local attractions', '9:00 AM'),
                  _buildActivityItem('Afternoon', 'Lunch and cultural sites', '1:00 PM'),
                  _buildActivityItem('Evening', 'Dinner and relaxation', '7:00 PM'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActivityItem(String time, String activity, String timeDisplay) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(activity),
          ),
          Text(
            timeDisplay,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: _previousStep,
                child: const Text('Previous'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _canProceed() ? _nextStep : null,
              child: Text(_currentStep == 4 ? 'Save Itinerary' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedDestination.isNotEmpty;
      case 1:
        return _startDate != null && _endDate != null;
      case 2:
        return _budget > 0;
      case 3:
        return _selectedInterests.isNotEmpty;
      case 4:
        return true;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_currentStep < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _saveItinerary();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _saveItinerary() {
    // Save itinerary logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Itinerary saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    context.go('/main/home');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
