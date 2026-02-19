import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'styling.dart';

const double _maxWidth = 560;
final Duration _animationDuration = Styling.durations.normal;

/// A modal alert popup for displaying important messages with optional actions.
///
/// AlertPopup provides a standardized way to show alerts, warnings, or
/// informational messages to users. It features a centered layout with
/// optional icon, title, description, and action button.
///
/// ## Example
///
/// ```dart
/// // Basic alert
/// AlertPopup.show(
///   context: context,
///   icon: Icon(Icons.warning, color: Colors.orange),
///   title: 'Delete Item',
///   description: 'This action cannot be undone. Are you sure?',
///   action: Button(
///     label: 'Delete',
///     variant: ButtonVariant.destructive,
///     onPressed: () => Navigator.pop(context),
///   ),
/// )
///
/// // Success message
/// AlertPopup.show(
///   context: context,
///   icon: Icon(Icons.check_circle, color: Colors.green),
///   title: 'Success!',
///   description: 'Your changes have been saved.',
///   action: Button(
///     label: 'OK',
///     onPressed: () => Navigator.pop(context),
///   ),
/// )
/// ```
///
/// ## Behavior
///
/// - Displays as a modal overlay with backdrop blur
/// - Responsive padding based on screen size
/// - Can be dismissed by tapping outside or pressing Escape
/// - Respects system reduced motion preferences
/// - Includes smooth scale and fade animations
/// - Maximum width of 560px for readability
///
/// ## Accessibility
///
/// - Properly labeled for screen readers
/// - Supports keyboard navigation and dismissal
/// - Includes semantic route information
/// - Maintains focus management
class AlertPopup extends StatelessWidget {
  /// Optional icon displayed above the title.
  ///
  /// Typically an Icon widget sized 48x48. Used to provide
  /// visual context for the alert (warning, success, error, etc.).
  final Widget? icon;

  /// The main title text displayed prominently.
  ///
  /// Should be concise and clearly communicate the alert's purpose.
  /// Uses centered alignment and bold typography.
  final String title;

  /// Optional descriptive text below the title.
  ///
  /// Provides additional context or details about the alert.
  /// Uses smaller font size and secondary text color.
  final String? description;

  /// Optional action button displayed at the bottom.
  ///
  /// Typically a Button widget for the primary action.
  /// When null, no action button is shown.
  final Widget? action;

  /// Creates an alert popup with the specified properties.
  ///
  /// The [title] parameter is required. All other parameters are optional.
  /// This constructor is typically used when creating custom alert types
  /// or when embedding alert content in other components.
  const AlertPopup({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.action,
  });

  /// Displays an alert popup with the specified content.
  ///
  /// This is the preferred way to show alerts. It handles the
  /// navigation, animation, and overlay management automatically.
  ///
  /// [context] is required and must have a valid Navigator.
  /// [icon] is optional and appears above the title.
  /// [title] is required and appears prominently.
  /// [description] is optional and provides additional context.
  /// [action] is optional and appears as the primary action button.
  ///
  /// Returns a Future that completes when the alert is dismissed.
  static Future<void> show({
    required BuildContext context,
    Widget? icon,
    required String title,
    String? description,
    Widget? action,
  }) {
    return Navigator.of(context).push(
      _AlertPopupRoute(
        icon: icon,
        title: title,
        description: description,
        action: action,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final styling = Styling.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= styling.breakpoints.desktop;

    final padding = isDesktop
        ? const EdgeInsets.only(top: 64, bottom: 48, left: 48, right: 48)
        : const EdgeInsets.only(top: 32, bottom: 24, left: 24, right: 24);

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: styling.colors.background,
        borderRadius: BorderRadius.circular(Styling.radii.large),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 8),
            color: const Color(0xFF000000).withAlpha(12),
          ),
          BoxShadow(
            blurRadius: 64,
            spreadRadius: 0,
            offset: const Offset(0, 24),
            color: const Color(0xFF000000).withAlpha(8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            SizedBox(
              width: 48,
              height: 48,
              child: FittedBox(
                fit: BoxFit.contain,
                child: icon!,
              ),
            ),
            const SizedBox(height: 24),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 28 / 18,
              fontWeight: FontWeight.w600,
              color: styling.colors.primaryText,
              decoration: TextDecoration.none,
            ),
          ),
          if (description != null && description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 20 / 14,
                fontWeight: FontWeight.w400,
                color: styling.colors.secondaryText,
                decoration: TextDecoration.none,
              ),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 32),
            action!,
          ],
        ],
      ),
    );
  }
}

class _AlertPopupRoute extends PageRouteBuilder {
  final Widget? icon;
  final String title;
  final String? description;
  final Widget? action;

  _AlertPopupRoute({
    this.icon,
    required this.title,
    this.description,
    this.action,
  }) : super(
         opaque: false,
         barrierDismissible: true,
         barrierColor: const Color(0x00000000),
         transitionDuration: _animationDuration,
         reverseTransitionDuration: _animationDuration,
         pageBuilder: (_, _, _) {
           return const SizedBox.shrink();
         },
       );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final bool reduceMotion = MediaQuery.of(context).disableAnimations;

    final double fade = reduceMotion
        ? 1.0
        : CurvedAnimation(parent: animation, curve: Curves.easeOut).value;
    final double scale = reduceMotion
        ? 1.0
        : Tween<double>(begin: 0.95, end: 1.0)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              )
              .value;
    final double blur = reduceMotion
        ? 8.0
        : Tween<double>(begin: 0, end: 8.0)
              .animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              )
              .value;

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: [
          // Barrier
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: ColoredBox(
                  color: Color.fromRGBO(0, 0, 0, 0.5 * fade),
                ),
              ),
            ),
          ),
          // Dialog
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Opacity(
                  opacity: fade,
                  child: Transform.scale(
                    scale: scale,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _maxWidth,
                      ),
                      child: Semantics(
                        scopesRoute: true,
                        explicitChildNodes: true,
                        label: 'Alert popup: $title',
                        child: AlertPopup(
                          icon: icon,
                          title: title,
                          description: description,
                          action: action,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
