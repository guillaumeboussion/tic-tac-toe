import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/core/design/widgets/base/text.dart';

class AppDropdownButton<T> extends StatelessWidget {
  final List<T> elements;
  final T valueToShow;
  final void Function(T? valueChanged) onChanged;

  const AppDropdownButton({
    required this.valueToShow,
    required this.elements,
    required this.onChanged,
    super.key,
  });

  String _getLabel(T value) {
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.small),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: theme.radius.small.asBorderRadius,
      ),
      child: DropdownButton<T>(
        value: valueToShow,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        underline: Container(),
        items: elements.map((e) {
          return DropdownMenuItem<T>(
            value: e,
            child: AppText.smallBody(_getLabel(e)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
