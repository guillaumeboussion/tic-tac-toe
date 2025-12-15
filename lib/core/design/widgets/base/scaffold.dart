import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';

class AppScaffold extends ConsumerWidget {
  const AppScaffold({
    this.title,
    this.titleText,
    this.centerTitle = false,
    required this.body,
    super.key,
  }) : assert(title != null || titleText != null);

  final Widget? title;
  final String? titleText;
  final Widget body;
  final bool centerTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colors.primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: centerTitle,
        title: title ??
            AppText.regularBoldBody(
              titleText!,
              fontWeight: FontWeight.w500,
            ),
        leading: IconButton(
          icon: Icon(
            context.router.current.route.fullscreenDialog ? Icons.close : Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
