import 'package:example/style.dart';
import 'package:flutter/widgets.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final typo = context.typography;
    final style = Style.of(context);
    final codeBackground = style.colors.border.withValues(alpha: 0.3);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Typography', style: typo.display),
          const SizedBox(height: 8),
          Text(
            'Built-in type scale with context-aware theming.',
            style: typo.body.muted(context),
          ),
          const SizedBox(height: 32),

          // Type scale
          _section(
            context,
            title: 'Type Scale',
            children: [
              _sample(context, 'display', '32/40 · w700', typo.display),
              _sample(context, 'heading', '24/32 · w600', typo.heading),
              _sample(context, 'title', '18/26 · w600', typo.title),
              _sample(context, 'subtitle', '16/24 · w500', typo.subtitle),
              _sample(context, 'body', '14/20 · w400', typo.body),
              _sample(context, 'bodySmall', '12/16 · w400', typo.bodySmall),
              _sample(context, 'caption', '11/15 · w400', typo.caption),
            ],
          ),

          // Extensions
          _section(
            context,
            title: 'Extensions',
            children: [
              _extensionDemo(
                context,
                label: '.muted(context)',
                child: Text('Muted text', style: typo.body.muted(context)),
              ),
              _extensionDemo(
                context,
                label: '.bold',
                child: Text('Bold text', style: typo.body.bold),
              ),
              _extensionDemo(
                context,
                label: '.w300 (light weight)',
                child: Text('Light weight text', style: typo.subtitle.w300),
              ),
              _extensionDemo(
                context,
                label: '.withColor(Color)',
                child: Text(
                  'Custom color',
                  style: typo.body.withColor(const Color(0xFF3B82F6)),
                ),
              ),
              _extensionDemo(
                context,
                label: '.withHeight(pixels)',
                child: Text(
                  'Tight line height (14px)',
                  style: typo.body.withHeight(14),
                ),
              ),
            ],
          ),

          // Usage
          _section(
            context,
            title: 'Usage',
            children: [
              _code(codeBackground, style, "context.typography.body"),
              const SizedBox(height: 8),
              _code(
                codeBackground,
                style,
                "context.typography.title.bold\n"
                    "context.typography.body.muted(context)\n"
                    "context.typography.subtitle.withColor(myColor)\n"
                    "context.typography.heading.w300",
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.typography.title),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _sample(
    BuildContext context,
    String name,
    String meta,
    TextStyle textStyle,
  ) {
    final muted = context.typography.caption.muted(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: muted),
          const SizedBox(height: 4),
          Text('The quick brown fox jumps over the lazy dog.', style: textStyle),
          const SizedBox(height: 2),
          Text(meta, style: muted),
        ],
      ),
    );
  }

  Widget _extensionDemo(
    BuildContext context, {
    required String label,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: context.typography.bodySmall.muted(context),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _code(Color background, Style style, String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Style.radii.small),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'monospace',
          color: style.colors.foreground,
          height: 1.6,
        ),
      ),
    );
  }

}
