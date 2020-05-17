import 'package:flutter/material.dart';

class SimpleTextField extends StatefulWidget {
  final TextEditingController controller;
  final double corner;
  final double borderWidth;
  final double width;
  final double height;
  final Color fillColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final String hint;
  final String title;
  final TextStyle titleStyle;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final bool isPasswordField;
  final bool isNumberField;
  final bool isTextareaField;
  final double paddingBorder;
  final InputBorder inputBorder;
  final Function(String) onTextChange;
  final Widget iconShowPass;
  final double contentPaddingBottom;

  const SimpleTextField(
      {Key key,
      @required this.controller,
      this.width,
      this.height,
      this.hint,
      this.title,
      this.textStyle = const TextStyle(fontSize: 16.0),
      this.hintStyle = const TextStyle(fontSize: 16.0, color: Colors.grey),
      this.titleStyle = const TextStyle(fontSize: 14.0),
      this.corner = 5,
      this.borderColor = Colors.grey,
      this.focusedBorderColor = Colors.blue,
      this.fillColor = Colors.white,
      this.backgroundColor = Colors.transparent,
      this.borderWidth = 2,
      this.isPasswordField = false,
      this.isNumberField = false,
      this.isTextareaField = false,
      this.paddingBorder = 0,
      this.inputBorder,
      this.onTextChange,
      this.iconShowPass,
      this.contentPaddingBottom = 10})
      : super(key: key);

  @override
  _SimpleTextFieldState createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  bool isPasswordField = false;

  @override
  void initState() {
    isPasswordField = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (widget.title != null && widget.title != '')
            ? Text(widget.title, style: widget.titleStyle)
            : const SizedBox(),
        SizedBox(
          height: (widget.title != null && widget.title != '') ? 5 : 0,
        ),
        Container(
          height: widget.isTextareaField ? widget.height * 3 : widget.height,
          width: widget.width,
          padding: EdgeInsets.symmetric(horizontal: widget.paddingBorder),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.corner),
            color: widget.backgroundColor,
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
          child: Align(
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                Theme(
                  data: ThemeData(
                    primaryColor: widget.focusedBorderColor,
                    primaryColorDark: widget.focusedBorderColor,
                  ),
                  child: TextField(
                    controller: widget.controller,
                    onChanged: widget.onTextChange,
                    style: widget.textStyle,
                    obscureText: isPasswordField,
                    keyboardType: widget.isNumberField
                        ? TextInputType.number
                        : TextInputType.text,
                    maxLines: widget.isTextareaField ? 5 : 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: widget.inputBorder,
                      hintText: widget.hint,
                      hintStyle: widget.hintStyle,
                      fillColor: widget.fillColor,
                      contentPadding: EdgeInsets.only(
                        right: widget.iconShowPass != null ? widget.height : 0,
                        bottom: widget.contentPaddingBottom,
                      ),
                    ),
                  ),
                ),
                widget.iconShowPass != null
                    ? IconButton(
                        icon: widget.iconShowPass,
                        iconSize: widget.height,
                        onPressed: () {
                          setState(() {
                            isPasswordField = !isPasswordField;
                          });
                        },
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
