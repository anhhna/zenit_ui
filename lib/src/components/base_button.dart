import 'package:zenit_ui/zenit_ui.dart';

class BaseButton extends StatefulWidget {
  const BaseButton({
    // Press
    this.onPressed,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    // Long Press
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressEnd,
    // Drag
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    // FocusNode
    this.focusNode,
    this.autofocus = false,
    this.onFocusChange,
    // Margin
    this.margin,
    // Semantics
    this.semanticLabel,
    // Child
    this.child,
    // Key
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;

  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressStart;
  final VoidCallback? onLongPressEnd;

  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;

  final FocusNode? focusNode;
  final bool autofocus;
  final ValueChanged<bool>? onFocusChange;

  final EdgeInsetsGeometry? margin;

  final String? semanticLabel;

  final Widget? child;

  @override
  _BaseButtonState createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  late FocusNode node;

  @override
  void initState() {
    super.initState();
    node = widget.focusNode ?? _createFocusNode();
  }

  @override
  void didUpdateWidget(BaseButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      node = widget.focusNode ?? node;
    }
  }

  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  @override
  void dispose() {
    if (widget.focusNode == null) node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: MergeSemantics(
        child: Semantics(
          label: widget.semanticLabel,
          button: true,
          //TODO enabled property
          enabled: true,
          focusable: true,
          focused: node.hasFocus,
          child: FocusableActionDetector(
            mouseCursor: SystemMouseCursors.click,
            focusNode: node,
            autofocus: widget.autofocus,
            //TODO enabled property
            enabled: true,
            onFocusChange: widget.onFocusChange,

            child: GestureDetector(
              // Behavior
              behavior: HitTestBehavior.opaque,
              // Press
              onTap: widget.onPressed,
              onTapDown: (_) => widget.onTapDown?.call(),
              onTapUp: (_) => widget.onTapUp?.call(),
              // Long Press
              onLongPress: widget.onLongPress,
              onLongPressStart: (_) => widget.onLongPressStart?.call(),
              onLongPressEnd: (_) => widget.onLongPressEnd?.call(),
              // Drag
              onHorizontalDragStart: widget.onHorizontalDragStart,
              onHorizontalDragUpdate: widget.onHorizontalDragUpdate,
              onHorizontalDragEnd: widget.onHorizontalDragEnd,
              // Child
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
