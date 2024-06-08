import 'package:flutter/material.dart';

class TagsInput extends StatefulWidget {
  final TextEditingController textController;
  final List<String> tags;

  const TagsInput({Key? key, required this.textController, required this.tags})
      : super(key: key);

  @override
  TagsInputState createState() => TagsInputState();
}

class TagsInputState extends State<TagsInput> {
  List<String> get _tags => widget.tags;
  TextEditingController get _textController => widget.textController;

  void _addTag(String tag) {
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
      });
      _textController.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _tags.map((tag) {
              return Chip(
                label: Text(tag),
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => _removeTag(tag),
              );
            }).toList(),
          ),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _addTag(_textController.text),
              ),
              hintText: 'Enter your Skills',
            ),
            onSubmitted: (value) => _addTag(_textController.text),
          ),
        ],
      ),
    );
  }
}
