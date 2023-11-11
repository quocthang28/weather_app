// SearchDelegate class for handling search functionality
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear button)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          // Clear the search text
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the search bar (e.g., back button)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Close the search box and return to the previous screen
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the results based on the search query
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Build suggestions that appear as the user types in the search bar
    return const SizedBox.shrink();
  }
}
