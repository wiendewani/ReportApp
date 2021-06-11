
import 'package:flutter/material.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class InputFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final String title, hint;

  InputFieldPassword({this.controller, this.title, this.hint});

  @override
  _InputFieldPasswordState createState() => _InputFieldPasswordState();
}

class _InputFieldPasswordState extends State<InputFieldPassword> {
  bool _isHide = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHide = !_isHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            widget.title,
            style: TypographyStyle.mini.merge(
              TextStyle(
                color: PaletteColor.grey60,
              ),
            ),
          ),
        ),
        TextFormField(
          validator: (value){
            if(value.isEmpty){
              return 'Input Tidak Boleh Kosong';
            }
            return null;
          },
          obscureText: _isHide,
          controller: widget.controller,
          cursorColor: PaletteColor.primary,
          keyboardType: TextInputType.visiblePassword,
          style: TypographyStyle.button1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: SpacingDimens.spacing16,
              top: SpacingDimens.spacing12,
              bottom: SpacingDimens.spacing8,
            ),
            hintText: widget.hint,
            hintStyle: TypographyStyle.paragraph.merge(
              TextStyle(
                color: PaletteColor.grey60,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: PaletteColor.primary,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                _isHide ? Icons.visibility_off : Icons.visibility,
                color: _isHide
                    ? PaletteColor.grey60
                    : PaletteColor.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
