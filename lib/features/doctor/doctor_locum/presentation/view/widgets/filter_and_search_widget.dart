import 'package:flutter/material.dart';
import 'package:locum_app/core/enums/filter_option_enum.dart';
import 'package:locum_app/core/enums/sort_options_enum.dart';
import 'package:locum_app/features/doctor/doctor_profile/presentation/views/widgets/custom_form_widgets.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final List<SortOptionsEnum> sortOptions = SortOptionsEnum.values;
  final List<FilterOptionsEnum> filterOptions = FilterOptionsEnum.values;

  SortOptionsEnum? selectedSort;
  FilterOptionsEnum? selectedFilter;
  final Map<FilterOptionsEnum, String> activeFilters = {};
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
                      child: DropdownButtonFormField<SortOptionsEnum>(
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
                            child: Text(option.toShortString()),
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
                DropdownButtonFormField<FilterOptionsEnum>(
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
                      child: Text(option.toShortString()),
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
                    label: 'Enter ${selectedFilter?.toShortString()}',
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

                // Add Filter Button
                if (selectedFilter != null)
                  ElevatedButton(
                    onPressed: () {
                      if (filterValueController.text.isNotEmpty) {
                        setState(() {
                          activeFilters.addAll({
                            selectedFilter!: filterValueController.text,
                          });
                          selectedFilter = null;
                          filterValueController.clear();
                        });
                      }
                    },
                    child: const Text('Add Filter'),
                  ),

                if (selectedFilter != null) const SizedBox(height: 16),

                // Active Filters Display
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: activeFilters.entries.map((filter) {
                    return Chip(
                      label: Text('${filter.key.toShortString()}: ${{filter.value}}'),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(() {
                          activeFilters.remove(filter.key);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                if (activeFilters.isNotEmpty) ElevatedButton(onPressed: () {}, child: const Text('Search')),
                if (activeFilters.isNotEmpty) const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
