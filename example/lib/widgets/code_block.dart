import 'package:example/widgets/copy_button.dart';
import 'package:flutter/material.dart' show SelectableText;
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeBlock extends StatefulWidget {
  final String code;

  const CodeBlock({super.key, required this.code});

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  static Highlighter? _highlighter;
  static bool _initialized = false;

  TextSpan? _highlighted;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(CodeBlock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code) _highlight();
  }

  Future<void> _init() async {
    if (!_initialized) {
      await Highlighter.initialize(['dart']);
      _highlighter = Highlighter(
        language: 'dart',
        theme: await HighlighterTheme.loadDarkTheme(),
      );
      _initialized = true;
    }
    _highlight();
  }

  void _highlight() {
    if (!_initialized) return;
    setState(() {
      _highlighted = _applyFont(_highlighter!.highlight(widget.code));
    });
  }

  TextSpan _applyFont(TextSpan span) {
    return TextSpan(
      text: span.text,
      style: span.style?.copyWith(
        fontFamily: _textStyle.fontFamily,
        fontFamilyFallback: _textStyle.fontFamilyFallback,
      ),
      children: span.children?.map((child) {
        if (child is TextSpan) return _applyFont(child);
        return child;
      }).toList(),
    );
  }

  static final _textStyle = GoogleFonts.jetBrainsMono(
    fontSize: 14,
    height: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _highlighted != null
                  ? SelectableText.rich(
                      _highlighted!,
                      style: _textStyle,
                    )
                  : SelectableText(
                      widget.code,
                      style: _textStyle.copyWith(
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: CopyButton(value: widget.code),
          ),
        ],
      ),
    );
  }
}
