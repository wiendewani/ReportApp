
import 'package:flutter/material.dart';
import 'package:reportapp/theme/PaletteColor.dart';
import 'package:reportapp/theme/SpacingDimens.dart';
import 'package:reportapp/theme/TypographyStyle.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String title, hint;
  final TextInputType type;

  InputField({this.controller, this.title, this.hint, this.type});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
              return 'Input tidak Boleh Kosong';
            }
            return null;
          },
          controller: widget.controller,
          cursorColor: PaletteColor.primary,
          keyboardType: widget.type,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: SpacingDimens.spacing16,
              top: SpacingDimens.spacing8,
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
          ),
        ),
      ],
    );
  }
}
