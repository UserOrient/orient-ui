import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'styling.dart';

class ConfirmationPopup extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? description;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool destructive;

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
  }) async {
    final OverlayState overlayState = Navigator.of(context).overlay!;
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (_) {
        return _ConfirmationPopupOverlay(
          icon: icon,
          title: title,
          description: description,
          confirmLabel: confirmLabel,
          destructive: destructive,
          cancelLabel: cancelLabel,
          onConfirm: onConfirm,
          onCancel: onCancel,
          onRemove: () {
            overlayEntry.remove();
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
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
        borderRadius: BorderRadius.circular(24),
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

class _ConfirmationPopupOverlay extends StatefulWidget {
  final Widget? icon;
  final String title;
  final String? description;
  final String confirmLabel;
  final String cancelLabel;
  final bool destructive;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final VoidCallback onRemove;

  const _ConfirmationPopupOverlay({
    required this.icon,
    required this.title,
    required this.description,
    required this.confirmLabel,
    required this.destructive,
    required this.cancelLabel,
    required this.onConfirm,
    required this.onCancel,
    required this.onRemove,
  });

  @override
  State<_ConfirmationPopupOverlay> createState() =>
      _ConfirmationPopupOverlayState();
}

class _ConfirmationPopupOverlayState extends State<_ConfirmationPopupOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _blurAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  void _exit() {
    _controller.reverse();
    widget.onRemove();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool reduceMotion = MediaQuery.of(context).disableAnimations;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.escape) {
            _exit();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final blur = reduceMotion ? 8.0 : _blurAnimation.value;
            final fade = reduceMotion ? 1.0 : _fadeAnimation.value;
            final scale = reduceMotion ? 1.0 : _scaleAnimation.value;

            return Stack(
              children: [
                // Barrier
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      _exit();
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
                            constraints: const BoxConstraints(maxWidth: 560),
                            child: Semantics(
                              scopesRoute: true,
                              explicitChildNodes: true,
                              label: 'Confirmation dialog: ${widget.title}',
                              child: ConfirmationPopup(
                                icon: widget.icon,
                                title: widget.title,
                                description: widget.description,
                                confirmLabel: widget.confirmLabel,
                                cancelLabel: widget.cancelLabel,
                                destructive: widget.destructive,
                                onConfirm: () {
                                  widget.onConfirm();
                                  _exit();
                                },
                                onCancel: () {
                                  widget.onCancel?.call();
                                  _exit();
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
            );
          },
        ),
      ),
    );
  }
}
