import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/data.dart';
import 'package:tic_tac_toe_app/core/design/theme/data/radius.dart';
import 'package:tic_tac_toe_app/core/design/theme/theme.dart';
import 'package:tic_tac_toe_app/features/game/domain/enums/cell_state.dart';

class GameCellWidget extends StatefulWidget {
  final CellState cellState;
  final bool isWinningCell;
  final VoidCallback onTap;

  const GameCellWidget({
    required this.cellState,
    required this.isWinningCell,
    required this.onTap,
    super.key,
  });

  @override
  State<GameCellWidget> createState() => _GameCellWidgetState();
}

class _GameCellWidgetState extends State<GameCellWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    if (widget.cellState != CellState.empty) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(GameCellWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cellState == CellState.empty && widget.cellState != CellState.empty) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return GestureDetector(
      onTap: widget.cellState == CellState.empty ? widget.onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: widget.isWinningCell
              ? (widget.cellState == CellState.playerOne
                  ? theme.colors.playerOneColor.withValues(alpha: 0.3)
                  : theme.colors.playerTwoColor.withValues(alpha: 0.3))
              : theme.colors.primaryColor,
          borderRadius: theme.radius.small.asBorderRadius,
          border: Border.all(
            color: widget.isWinningCell
                ? (widget.cellState == CellState.playerOne ? theme.colors.playerOneColor : theme.colors.playerTwoColor)
                : theme.colors.inputBorder.withValues(alpha: 0.3),
            width: widget.isWinningCell ? 3 : 1,
          ),
          boxShadow: widget.isWinningCell
              ? [
                  BoxShadow(
                    color: (widget.cellState == CellState.playerOne
                            ? theme.colors.playerOneColor
                            : theme.colors.playerTwoColor)
                        .withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Center(
                child: _buildCellContent(theme),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget? _buildCellContent(AppThemeData theme) {
    switch (widget.cellState) {
      case CellState.empty:
        return null;
      case CellState.playerOne:
        return Icon(
          Icons.close,
          size: 48,
          color: theme.colors.playerOneColor,
        );
      case CellState.playerTwo:
        return Icon(
          Icons.radio_button_unchecked,
          size: 48,
          color: theme.colors.playerTwoColor,
        );
    }
  }
}
