import 'package:flutter/material.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final List<String> sortOptions = ['Published At', 'Salary'];
  final List<String> filterOptions = [
    'Speciality',
    'Job Title',
    'Job Type',
    'State',
    'District',
    'Languages',
    'Skills',
  ];

  String? selectedSort;
  String? selectedFilter;
  final List<Map<String, String>> activeFilters = [];
  final TextEditingController filterValueController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isVisible
                      ? const Text(
                          'Find Your Dream Job',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isVisible = true;
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.search, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Search For Your Perfect Job',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                  if (isVisible) const Spacer(),
                  if (isVisible)
                    InkWell(
                      child: const Icon(Icons.close),
                      onTap: () {
                        setState(() {
                          isVisible = false;
                        });
                      },
                    )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: isVisible,
          child: Material(
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sort Dropdown
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Sort By',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        value: selectedSort,
                        items: sortOptions.map((option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSort = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Filter Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Filter By',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  value: selectedFilter,
                  items: filterOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFilter = value;
                      filterValueController.clear();
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Filter Value Input
                if (selectedFilter != null)
                  CustomTextFormFieldWithSuggestions(
                    label: 'Enter $selectedFilter',
                    suggestions: const ['Value 1', 'Value 2', 'Value 3'],
                    onSelected: (suggestion) {
                      filterValueController.text = suggestion;
                    },
                    controller: filterValueController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value for $selectedFilter';
                      }
                      return null;
                    },
                  ),
                // TypeAheadField<String>(
                //   textFieldConfiguration: TextFieldConfiguration(
                //     controller: filterValueController,
                //     decoration: InputDecoration(
                //       labelText: 'Enter $selectedFilter',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //   ),
                //   suggestionsCallback: (pattern) async {
                //     // Mock suggestion data, replace with API call if needed
                //     return ['Value 1', 'Value 2', 'Value 3']
                //         .where((item) => item.toLowerCase().contains(pattern.toLowerCase()))
                //         .toList();
                //   },
                //   itemBuilder: (context, suggestion) {
                //     return ListTile(
                //       title: Text(suggestion),
                //     );
                //   },
                //   onSuggestionSelected: (suggestion) {
                //     filterValueController.text = suggestion;
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter a value for $selectedFilter';
                //     }
                //     return null;
                //   },
                // ),

                const SizedBox(height: 16),

                // Add Filter Button
                if (selectedFilter != null)
                  ElevatedButton(
                    onPressed: () {
                      if (filterValueController.text.isNotEmpty) {
                        setState(() {
                          activeFilters.add({
                            'filter': selectedFilter!,
                            'value': filterValueController.text,
                          });
                          selectedFilter = null;
                          filterValueController.clear();
                        });
                      }
                    },
                    child: const Text('Add Filter'),
                  ),

                const SizedBox(height: 16),

                // Active Filters Display
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: activeFilters.map((filter) {
                    return Chip(
                      label: Text('${filter['filter']}: ${filter['value']}'),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(() {
                          activeFilters.remove(filter);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
