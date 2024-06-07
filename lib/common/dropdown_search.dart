import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';



class TypeAheadUtils {
  static Widget buildTypeAheadField({
    required String hintText,
    required List<dynamic> data,
    required bool readOnly,
    required Function(dynamic) onSuggestionSelected,
    required String Function(dynamic) suggestionLabel,
    required List<String> selectedItems,
    required void Function() onDelete,
    required TextEditingController textController
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        TypeAheadField(
          controller: textController,
          builder: (context, controller, focusNode) => TextField(
            controller: textController,
            readOnly: false,
            focusNode: focusNode,
            autofocus: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
          ),
          suggestionsCallback: (pattern) async {
            return data
                .where((item) => suggestionLabel(item)
                .toLowerCase()
                .contains(pattern.toLowerCase()))
                .toList();
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestionLabel(suggestion)),
            );
          },
          onSelected: (suggestion) {
            onSuggestionSelected(suggestion);
          },

          emptyBuilder: (context) => const ListTile(
            title: Text('No items found'),
          ),
        ),
      ],
    );
  }
}