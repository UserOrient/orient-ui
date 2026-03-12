import 'package:example/style.dart';
import 'package:flutter/widgets.dart';

enum InfoBannerVariant { info, warning, error, success, neutral }

class InfoBanner extends StatelessWidget {
  final String title;
  final String? description;
  final InfoBannerVariant variant;
  final Widget? icon;

  const InfoBanner({
    super.key,
    required this.title,
    this.description,
    this.variant = InfoBannerVariant.info,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Style style = Style.of(context);
    final ColorTokens colors = style.colors;

    final Color color = switch (variant) {
      InfoBannerVariant.info => colors.info,
      InfoBannerVariant.warning => colors.warning,
      InfoBannerVariant.error => colors.error,
      InfoBannerVariant.success => colors.success,
      InfoBannerVariant.neutral => colors.mutedForeground,
    };

    final Color bgColor = color.withValues(alpha: 0.1);

    final bool hasDescription = description != null && description!.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: hasDescription
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Padding(
              padding: hasDescription
                  ? const EdgeInsets.only(top: 2)
                  : EdgeInsets.zero,
              child: icon,
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: hasDescription
                      ? context.typography.body.w600.withColor(color)
                      : context.typography.body.withColor(color),
                ),
                if (hasDescription) ...[
                  const SizedBox(height: 4),
                  Text(
                    description!,
                    style: context.typography.body.withColor(color),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
