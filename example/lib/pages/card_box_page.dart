import 'package:example/styling.dart';
import 'package:example/widgets/card_box.dart';
import 'package:example/widgets/demo_section.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class CardBoxPage extends StatelessWidget {
  const CardBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Styling.of(context).colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats card — dashboard KPI style
        DemoSection(
          title: 'Bordered',
          child: CardBox(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainer,
                    borderRadius:
                        BorderRadius.circular(Styling.radii.small),
                  ),
                  child: Center(
                    child: Icon(
                      TablerIcons.chart_bar,
                      size: 22,
                      color: colors.primaryText,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Revenue',
                        style: TextStyle(
                          fontSize: 13,
                          color: colors.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$12,840',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: colors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withValues(alpha: 0.12),
                    borderRadius:
                        BorderRadius.circular(Styling.radii.small),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        TablerIcons.trending_up,
                        size: 14,
                        color: Color(0xFF22C55E),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '+14%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF22C55E),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Pricing cards — row on desktop, column on mobile
        DemoSection(
          title: 'Filled',
          child: Builder(
            builder: (context) {
              final isDesktop = MediaQuery.of(context).size.width >=
                  Styling.breakpoints.desktop;

              final proCard = CardBox(
                variant: CardBoxVariant.filled,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pro',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: colors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$29/mo',
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _featureRow(colors, TablerIcons.check, '10 projects'),
                    const SizedBox(height: 6),
                    _featureRow(colors, TablerIcons.check, 'Email support'),
                    const SizedBox(height: 6),
                    _featureRow(colors, TablerIcons.check, '5 GB storage'),
                  ],
                ),
              );

              final enterpriseCard = CardBox(
                variant: CardBoxVariant.filled,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Enterprise',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: colors.primaryText,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.accent,
                            borderRadius:
                                BorderRadius.circular(Styling.radii.small),
                          ),
                          child: Text(
                            'Popular',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: colors.accentForeground,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$99/mo',
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _featureRow(colors, TablerIcons.check, 'Unlimited projects'),
                    const SizedBox(height: 6),
                    _featureRow(colors, TablerIcons.check, 'Priority support'),
                    const SizedBox(height: 6),
                    _featureRow(colors, TablerIcons.check, '100 GB storage'),
                  ],
                ),
              );

              if (isDesktop) {
                return Row(
                  children: [
                    Expanded(child: proCard),
                    const SizedBox(width: 12),
                    Expanded(child: enterpriseCard),
                  ],
                );
              }

              return Column(
                children: [
                  proCard,
                  const SizedBox(height: 12),
                  enterpriseCard,
                ],
              );
            },
          ),
        ),

        // Clickable notification card
        DemoSection(
          title: 'Clickable',
          child: CardBox(
            onTap: () {},
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                    borderRadius:
                        BorderRadius.circular(Styling.radii.small),
                  ),
                  child: const Center(
                    child: Icon(
                      TablerIcons.bell,
                      size: 18,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New deployment succeeded',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colors.primaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Production build v2.4.1 deployed 3 min ago.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: colors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  TablerIcons.chevron_right,
                  size: 18,
                  color: colors.secondaryText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _featureRow(ColorTokens colors, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: colors.primaryText),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: colors.primaryText,
            ),
          ),
        ),
      ],
    );
  }
}
