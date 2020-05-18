import 'package:flutter/material.dart';

import 'simple_button_controller.dart';

// ignore: constant_identifier_names
enum IconSide { Left, Right, Top, Bottom }

class SimpleIconButton extends StatefulWidget {
  final double height;
  final double width;
  final Color color;
  final List<Color> gradientColors;
  final String text;
  final TextStyle textStyle;
  final Function onPressed;
  final double borderRadius;
  final Widget icon;
  final Widget iconDisable;
  final Axis iconAxis;
  final double borderWidth;
  final Color borderColor;
  final IconSide iconSide;
  final EdgeInsets padding;
  final SimpleButtonController controller;

  const SimpleIconButton({
    Key key,
    this.height,
    this.width,
    this.color = Colors.black12,
    this.gradientColors,
    this.text,
    this.onPressed,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.borderRadius,
    this.icon = const SizedBox(),
    this.iconDisable = const SizedBox(),
    this.iconAxis = Axis.vertical,
    this.borderColor = Colors.grey,
    this.borderWidth = 0,
    this.iconSide = IconSide.Top,
    this.padding = const EdgeInsets.all(3),
    this.controller,
  }) : super(key: key);

  @override
  _SimpleIconButtonState createState() => _SimpleIconButtonState();
}

class _SimpleIconButtonState extends State<SimpleIconButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: widget.controller?.itemStream,
      initialData: widget.controller?.state,
      builder: (context, snapshot) {
        final ButtonState state = snapshot.hasError || !snapshot.hasData
            ? ButtonState.enable
            : snapshot.data;
        final bool isEnable = state == ButtonState.enable;

        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? widget.height ?? 16 / 2,
            ),
            border: Border.all(
              width: widget.borderWidth,
              color: isEnable ? widget.borderColor : Colors.transparent,
            ),
            gradient: _gradient(isEnable),
          ),
          child: RawMaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? widget.height ?? 16 / 2,
              ),
            ),
            fillColor: _bgColor(isEnable),
            elevation: 0.0,
            onPressed: isEnable ? widget.onPressed : null,
            padding: widget.padding,
            child: Align(child: getContent(isEnable)),
          ),
        );
      },
    );
  }

  bool get isActiveGradient =>
      widget.gradientColors != null && widget.gradientColors.length >= 2;

  Color _bgColor(bool isEnable) {
    if (isActiveGradient) {
      return null;
    }
    if (widget.color == null || !isEnable) {
      return Colors.black12;
    }
    return widget.color;
  }

  Gradient _gradient(bool isEnable) {
    if (isActiveGradient) {
      return LinearGradient(
        colors: isEnable
            ? widget.gradientColors
            : const [Colors.black12, Colors.black12],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
    return null;
  }

  Widget getContent(bool isEnable) {
    if (widget.icon == null) {
      if (widget.text == null) {
        return const SizedBox();
      }
      return Text(
        widget.text,
        style: isEnable
            ? widget.textStyle
            : widget.textStyle.copyWith(color: Colors.grey),
      );
    } else if (widget.text == null) {
      return isEnable ? widget.icon : widget.iconDisable;
    }

    List<Widget> contents;

    switch (widget.iconSide) {
      case IconSide.Right:
      case IconSide.Bottom:
        contents = [
          Text(
            widget.text,
            style: isEnable
                ? widget.textStyle
                : widget.textStyle.copyWith(color: Colors.grey),
          ),
          isEnable ? widget.icon : widget.iconDisable
        ];
        break;

      case IconSide.Top:
      case IconSide.Left:
      default:
        contents = [
          isEnable ? widget.icon : widget.iconDisable,
          Text(
            widget.text,
            style: widget.textStyle,
          )
        ];
    }

    if (widget.iconAxis == Axis.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: contents,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: contents,
      );
    }
  }
}
