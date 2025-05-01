import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:halal_media/core/theme/app_color.dart';

class NoteEditorBottomSheet extends StatefulWidget {
  final String? initialContent;

  const NoteEditorBottomSheet({super.key, this.initialContent});

  @override
  State<NoteEditorBottomSheet> createState() => _NoteEditorBottomSheetState();
}

class _NoteEditorBottomSheetState extends State<NoteEditorBottomSheet> {
  late final QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.initialContent != null
            ? QuillController(
              document: Document.fromDelta(
                Delta()..insert(widget.initialContent!),
              ),
              selection: const TextSelection.collapsed(offset: 0),
            )
            : QuillController.basic();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          QuillSimpleToolbar(controller: _controller),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.black200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: QuillEditor.basic(controller: _controller),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.deepGreen,
              minimumSize: const Size.fromHeight(40),
            ),
            onPressed: () {
              final content = _controller.document.toPlainText().trim();
              Navigator.pop(context, content);
            },
            child: const Text("Save Note"),
          ),
        ],
      ),
    );
  }
}
