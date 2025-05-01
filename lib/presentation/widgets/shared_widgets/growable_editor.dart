import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:halal_media/core/theme/app_color.dart';
import 'package:halal_media/core/theme/text_design.dart';
import 'package:halal_media/core/utils/app_dimension.dart';
import 'package:halal_media/presentation/widgets/button/custom_text_button.dart';
import 'package:hexcolor/hexcolor.dart';

class GrowableQuillBox extends StatefulWidget {
  final QuillController controller;
  final String placeholder;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const GrowableQuillBox({
    super.key,
    required this.controller,
    this.placeholder = "Note...",
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<GrowableQuillBox> createState() => _GrowableQuillBoxState();
}

class _GrowableQuillBoxState extends State<GrowableQuillBox> {
  final FocusNode _focusNode = FocusNode();
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    widget.controller.addListener(() {
      // Scroll to caret (cursor) position
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ), // handles keyboard space
      child: SingleChildScrollView(
        reverse: true, // ensures newest input stays visible
        child: Container(
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.black200, width: 1),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.greenish,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          border: BorderDirectional(
                            bottom: BorderSide(
                              color: AppColor.border,
                              width: 1,
                            ),
                          ),
                        ),
                        child: QuillSimpleToolbar(
                          controller: widget.controller,
                          config: QuillSimpleToolbarConfig(
                            toolbarIconCrossAlignment: WrapCrossAlignment.start,
                            toolbarIconAlignment: WrapAlignment.start,
                            toolbarSectionSpacing: 0,
                            showBoldButton: true,
                            showItalicButton: true,
                            showHeaderStyle: true,
                            showQuote: true,
                            showLink: true,

                            showListNumbers: true,
                            showListBullets: true,
                            showDividers: false,
                            showFontFamily: false,
                            showFontSize: false,
                            showLineHeightButton: false,
                            showStrikeThrough: false,
                            showInlineCode: false,
                            showColorButton: false,
                            showBackgroundColorButton: false,
                            showClearFormat: false,
                            showAlignmentButtons: false,
                            showListCheck: false,
                            showCodeBlock: false,
                            showIndent: false,
                            showDirection: false,
                            showUndo: false,
                            showRedo: false,
                            showSearchButton: false,
                            showSubscript: false,
                            showSuperscript: false,
                            showClipboardCut: false,
                            showClipboardCopy: false,
                            showClipboardPaste: false,
                            showUnderLineButton: false,
                            buttonOptions: QuillSimpleToolbarButtonOptions(
                              base: QuillToolbarBaseButtonOptions(
                                iconTheme: QuillIconTheme(
                                  iconButtonSelectedData: IconButtonData(
                                    color: AppColor.deepGreen,
                                    style: ButtonStyle(
                                      tapTargetSize:
                                          MaterialTapTargetSize.padded,
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            360,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                        AppColor.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      constraints: BoxConstraints(
                        minHeight: 55,
                        maxHeight: 300,
                      ),
                      child: QuillEditor(
                        scrollController: _scrollController,
                        controller: widget.controller,
                        focusNode: _focusNode,

                        config: QuillEditorConfig(
                          scrollable: true,

                          customStyles: DefaultStyles(
                            placeHolder: DefaultListBlockStyle(
                              TextDesign().hintText,
                              HorizontalSpacing.zero,
                              VerticalSpacing.zero,
                              VerticalSpacing.zero,
                              null,
                              null,
                            ),
                          ),
                          placeholder: widget.placeholder,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              AppDimension.h4,

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     CustomTextButton(
              //       ontap: widget.onRemove,
              //       text: "Clear",
              //       fontSize: 16,
              //       color: AppColor.black600,
              //     ),

              //     AppDimension.w16,
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
