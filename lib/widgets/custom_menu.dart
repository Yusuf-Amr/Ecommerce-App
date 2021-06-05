//override popupMenuItem method to control handle tap to be able to edit and delete
import 'package:flutter/material.dart';

class CustomPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  CustomPopupMenuItem({
    @required this.child,
    @required this.onClick,
  }) : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return CustomPopupItemState();
  }
}

class CustomPopupItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, CustomPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
