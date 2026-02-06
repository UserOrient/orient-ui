import 'package:example/styling.dart';
import 'package:flutter/widgets.dart';

class DocsPage extends StatelessWidget {
  const DocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);
    final codeBackground = styling.colors.border.withValues(alpha: 0.3);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orient UI',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: styling.colors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Design system for Flutter without Material or Cupertino.',
            style: TextStyle(
              fontSize: 16,
              color: styling.colors.secondaryText,
            ),
          ),
          const SizedBox(height: 32),
          _buildSection(
            styling: styling,
            title: 'Getting Started',
            children: [
              _buildStep(styling, '1', 'Install the CLI', codeBackground,
                  'dart pub global activate orient_ui'),
              _buildStep(styling, '2', 'Initialize', codeBackground,
                  'orient_ui init'),
              _buildStep(
                  styling,
                  '3',
                  'Wrap your app',
                  codeBackground,
                  'Styling(\n'
                      '  brightness: Brightness.light,\n'
                      '  child: MaterialApp(\n'
                      '    home: MyHomePage(),\n'
                      '  ),\n'
                      ')'),
              _buildStep(styling, '4', 'Add components', codeBackground,
                  'orient_ui add button'),
            ],
          ),
          _buildSection(
            styling: styling,
            title: 'Commands',
            children: [
              _buildCodeBlock(
                  codeBackground,
                  styling,
                  'orient_ui init          # Initialize styling\n'
                      'orient_ui add           # List components\n'
                      'orient_ui add <widget>  # Add a component'),
            ],
          ),
          _buildSection(
            styling: styling,
            title: 'Components',
            children: [
              _buildComponentList(styling, [
                'Button (6 variants)',
                'Toggle',
                'CopyButton',
                'SearchField',
                'Spinner',
                'Toast',
                'AlertPopup',
                'ConfirmationPopup',
                'Popup',
                'EmptyState',
                'NavBar',
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required StylingData styling,
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: styling.colors.primaryText,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildStep(
    StylingData styling,
    String number,
    String title,
    Color codeBackground,
    String code,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. $title',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: styling.colors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          _buildCodeBlock(codeBackground, styling, code),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(
    Color background,
    StylingData styling,
    String code,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Styling.radii.small),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'monospace',
          color: styling.colors.primaryText,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildComponentList(StylingData styling, List<String> components) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: components
          .map((name) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    color: styling.colors.primaryText,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
