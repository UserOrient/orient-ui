import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'styling.dart';

const double _maxWidth = 560;
final Duration _animationDuration = Styling.durations.normal;

/// A modal confirmation dialog for yes/no or confirm/cancel decisions.
///
/// ConfirmationPopup provides a standardized way to request user confirmation
/// for potentially destructive or important actions. It features a centered
/// layout with optional icon, title, description, and dual action buttons.
///
/// ## Example
///
/// ```dart
/// // Delete confirmation
/// ConfirmationPopup.show(
///   context: context,
///   icon: Icon(Icons.delete, color: Colors.red),
///   title: 'Delete Item',
///   description: 'This action cannot be undone. Are you sure?',
///   confirmLabel: 'Delete',
///   cancelLabel: 'Cancel',
///   destructive: true,
///   onConfirm: () => _deleteItem(),
/// )
///
/// // Save confirmation
/// ConfirmationPopup.show(
///   context: context,
///   title: 'Save Changes',
///   description: 'Do you want to save your changes before leaving?',
///   confirmLabel: 'Save',
///   cancelLabel: 'Don\'t Save',
///   onConfirm: () => _saveChanges(),
/// )
/// ```
///
/// ## Behavior
///
/// - Displays as a modal overlay with backdrop blur
/// - Responsive padding based on screen size
/// - Can be dismissed by tapping outside, pressing Escape, or cancel action
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
class ConfirmationPopup extends StatelessWidget {
  /// Optional icon displayed above the title.
  ///
  /// Typically an Icon widget sized 48x48. Used to provide
  /// visual context for the confirmation (warning, info, etc.).
  final Widget? icon;

  /// The main title text displayed prominently.
  ///
  /// Should be concise and clearly communicate the action requiring confirmation.
  /// Uses centered alignment and bold typography.
  final String title;

  /// Optional descriptive text below the title.
  ///
  /// Provides additional context or details about the action.
  /// Uses smaller font size and secondary text color.
  final String? description;

  /// The text label for the confirm/primary action button.
  ///
  /// Should be action-oriented and clear (e.g., "Delete", "Save", "Confirm").
  final String confirmLabel;

  /// The text label for the cancel/secondary action button.
  ///
  /// Should clearly indicate cancellation (e.g., "Cancel", "Don't Save", "No").
  final String cancelLabel;

  /// Callback function called when the confirm action is triggered.
  ///
  /// Called when the user taps the confirm button. The popup is
  /// automatically dismissed after this callback executes.
  final VoidCallback onConfirm;

  /// Optional callback function called when the cancel action is triggered.
  ///
  /// Called when the user taps the cancel button or dismisses the popup.
  /// The popup is automatically dismissed after this callback executes.
  final VoidCallback? onCancel;

  /// Whether the confirmation action is destructive.
  ///
  /// When true, the confirm button uses destructive styling
  /// (red background) to indicate potential data loss or irreversible actions.
  ///
  /// Defaults to `false`.
  final bool destructive;

  /// Creates a confirmation popup with the specified properties.
  ///
  /// All parameters except [onCancel] and [destructive] are required.
  /// This constructor is typically used when creating custom confirmation types.
  const ConfirmationPopup({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    required this.onCancel,
    required this.destructive,
  });

  /// Displays a confirmation popup with the specified content.
  ///
  /// This is the preferred way to show confirmations. It handles the
  /// navigation, animation, and overlay management automatically.
  ///
  /// [context] is required and must have a valid Navigator.
  /// [icon] is optional and appears above the title.
  /// [title] is required and appears prominently.
  /// [description] is optional and provides additional context.
  /// [confirmLabel] and [cancelLabel] are required for the action buttons.
  /// [onConfirm] is required and called when confirmed.
  /// [onCancel] is optional and called when cancelled.
  /// [destructive] determines confirm button styling.
  ///
  /// Returns a Future that completes when the confirmation is handled.
  static Future<void> show({
    required BuildContext context,
    Widget? icon,
    required String title,
    String? description,
    required String confirmLabel,
    required String cancelLabel,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    bool destructive = false,
  }) {
    return Navigator.of(context).push(
      _ConfirmationPopupRoute(
        icon: icon,
        title: title,
        description: description,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        destructive: destructive,
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
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: Button(
                  label: cancelLabel,
                  onPressed: onCancel,
                  variant: ButtonVariant.secondary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Button(
                  label: confirmLabel,
                  onPressed: onConfirm,
                  variant: destructive
                      ? ButtonVariant.destructive
                      : ButtonVariant.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConfirmationPopupRoute extends PageRouteBuilder {
  final Widget? icon;
  final String title;
  final String? description;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool destructive;

  _ConfirmationPopupRoute({
    this.icon,
    required this.title,
    this.description,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    this.onCancel,
    this.destructive = false,
  }) : super(
         opaque: false,
         barrierDismissible: true,
         barrierColor: const Color(0x00000000),
         transitionDuration: _animationDuration,
         reverseTransitionDuration: _animationDuration,
         pageBuilder: (_, __, ___) => const SizedBox.shrink(),
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
                        label: 'Confirmation dialog: $title',
                        child: ConfirmationPopup(
                          icon: icon,
                          title: title,
                          description: description,
                          confirmLabel: confirmLabel,
                          cancelLabel: cancelLabel,
                          destructive: destructive,
                          onConfirm: () {
                            onConfirm();
                            Navigator.of(context).pop();
                          },
                          onCancel: () {
                            onCancel?.call();
                            Navigator.of(context).pop();
                          },
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
