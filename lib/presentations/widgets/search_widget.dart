import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';
import 'package:music_player/constants/palettes/color_palette.dart';


class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.textController,
    required this.validator,
    this.onChanged,
  });
  final String hintText;
  final IconData icon;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        style: const TextStyle(color: krose,fontFamily: ('Itim'),),
        textCapitalization: TextCapitalization.sentences,
        onChanged: onChanged,
        validator: validator,
        controller: textController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: krose,
            size: 25,
          ),
          hintText: hintText,
          hintStyle:  const TextStyle(color:krose),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 0, color: krose),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 0, color: krose),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 1,
              color: krose
            ),
          ),
        ),
      ),
    );
  }
}