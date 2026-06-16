// lib/core/widgets/app_widgets.dart
//
// Yahan sab reusable widgets hain — import karo aur use karo
// import 'package:sample1/core/widgets/app_widgets.dart';

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_dimensions.dart';

// ══════════════════════════════════════════════════════════
//  1. APP CARD
// ══════════════════════════════════════════════════════════
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final VoidCallback? onTap;
  final bool hasBorder;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
    this.hasBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? AppDimens.cardPadding,
        decoration: BoxDecoration(
          color: color ?? AppColors.surface,
          borderRadius: AppDimens.br16,
          border: hasBorder
              ? Border.all(color: AppColors.divider)
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
//  2. GRADIENT HEADER CARD (Dashboard welcome card)
// ══════════════════════════════════════════════════════════
class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final EdgeInsetsGeometry? padding;

  const GradientCard({
    super.key,
    required this.child,
    this.colors,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? AppDimens.cardPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors ?? [AppColors.primary, AppColors.primaryLighter],
        ),
        borderRadius: AppDimens.br20,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ══════════════════════════════════════════════════════════
//  3. STAT CARD (Dashboard count cards)
// ══════════════════════════════════════════════════════════
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppDimens.cardPadding,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppDimens.br16,
          border: Border.all(color: color.withOpacity(0.4), width: 1.5), // ← color border
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08), // ← colored shadow bhi
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: AppDimens.br8,
              ),
              child: Icon(icon, color: color, size: AppDimens.iconMd),
            ),
            Gap.h12,
            Text(value, style: AppTextStyles.amountMedium.copyWith(color: color)),
            Gap.h4,
            Text(title, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
//  4. ACTION CARD (Quick action grid)
// ══════════════════════════════════════════════════════════
class ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppDimens.br16,
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: c.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: c, size: AppDimens.iconLg),
            ),
            Gap.h10,
            Text(title, style: AppTextStyles.h4),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
//  5. INFO CARD (Consumer/Meter detail sections)
// ══════════════════════════════════════════════════════════
class InfoCard extends StatelessWidget {
  final String title;
  final IconData? titleIcon;
  final List<InfoRow> rows;
  final bool isLoading;
  final Widget? trailing;

  const InfoCard({
    super.key,
    required this.title,
    this.titleIcon,
    required this.rows,
    this.isLoading = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              if (titleIcon != null) ...[
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: AppDimens.br6,
                  ),
                  child: Icon(titleIcon, color: AppColors.primary,
                      size: AppDimens.iconSm),
                ),
                Gap.w10,
              ],
              Expanded(child: Text(title, style: AppTextStyles.h3)),
              if (trailing != null) trailing!,
            ],
          ),
          const Divider(height: 20),

          // Rows
          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            ...rows.map((row) => _InfoRowWidget(row: row)),
        ],
      ),
    );
  }
}

class InfoRow {
  final String label;
  final String value;
  final Color? valueColor;
  const InfoRow(this.label, this.value, {this.valueColor});
}

class _InfoRowWidget extends StatelessWidget {
  final InfoRow row;
  const _InfoRowWidget({required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(row.label, style: AppTextStyles.labelLarge),
          ),
          const Text(' : ',
              style: TextStyle(color: AppColors.textHint)),
          Expanded(
            child: Text(
              row.value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: row.valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
//  6. APP BUTTON (Primary)
// ══════════════════════════════════════════════════════════
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final btnColor = color ?? AppColors.primary;

    final child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppDimens.iconSm),
                Gap.w8,
              ],
              Text(label),
            ],
          );

    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        height: height ?? AppDimens.buttonHeight,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: btnColor,
            side: BorderSide(color: btnColor, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: AppDimens.br12),
            textStyle: AppTextStyles.buttonText,
          ),
          child: child,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: height ?? AppDimens.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: AppDimens.br12),
          textStyle: AppTextStyles.buttonText,
          elevation: 0,
        ),
        child: child,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
//  7. STATUS BADGE
// ══════════════════════════════════════════════════════════
class StatusBadge extends StatelessWidget {
  final String status;
  final String? label;

  const StatusBadge({super.key, required this.status, this.label});

  @override
  Widget build(BuildContext context) {
    final color   = AppColors.statusColor(status);
    final bgColor = AppColors.statusBgColor(status);
    final text    = label ?? _formatStatus(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppDimens.brFull,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6, height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          Gap.w6,
          Text(text,
              style: AppTextStyles.labelMedium.copyWith(color: color)),
        ],
      ),
    );
  }

  String _formatStatus(String s) {
    return s.replaceAll('_', ' ').split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }
}

// ══════════════════════════════════════════════════════════
//  8. APP TEXT FIELD
// ══════════════════════════════════════════════════════════
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;
  final bool readOnly;

  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:    controller,
      obscureText:   obscureText,
      keyboardType:  keyboardType,
      validator:     validator,
      onChanged:     onChanged,
      maxLines:      maxLines,
      readOnly:      readOnly,
      style:         AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        labelText:   label,
        hintText:    hint,
        prefixIcon:  prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon:  suffixIcon
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
//  9. SECTION HEADER
// ══════════════════════════════════════════════════════════
class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.h2),
        if (action != null)
          TextButton(
            onPressed: onAction,
            child: Text(action!),
          ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════
//  10. EMPTY STATE
// ══════════════════════════════════════════════════════════
class EmptyState extends StatelessWidget {
  final String message;
  final String? subtitle;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.message,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 48, color: AppColors.textHint),
            ),
            Gap.h20,
            Text(message, style: AppTextStyles.h3, textAlign: TextAlign.center),
            if (subtitle != null) ...[
              Gap.h8,
              Text(subtitle!, style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center),
            ],
            if (actionLabel != null) ...[
              Gap.h24,
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
                height: AppDimens.buttonHeightSm,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
//  11. LOADING STATE
// ══════════════════════════════════════════════════════════
class LoadingState extends StatelessWidget {
  final String? message;
  const LoadingState({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            Gap.h16,
            Text(message!, style: AppTextStyles.bodySmall),
          ],
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════
//  12. ERROR STATE
// ══════════════════════════════════════════════════════════
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorState({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.error_outline,
                  color: AppColors.error, size: 40),
            ),
            Gap.h16,
            Text(message,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center),
            if (onRetry != null) ...[
              Gap.h20,
              AppButton(
                label: 'Retry',
                onPressed: onRetry,
                icon: Icons.refresh,
                height: AppDimens.buttonHeightSm,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
