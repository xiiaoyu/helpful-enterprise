import 'package:flutter/material.dart';
import 'package:helpful_app/constant.dart';

class FlexibleTextFormField extends StatelessWidget {
  final GlobalKey<State> globalKey;
  final String hintText;
  final TextEditingController textEditingController;
  final int flexNumber;
  final TextInputType textInputType;
  final Function onChangeFunction;
  final Function validatorFunction;

  FlexibleTextFormField({
    this.globalKey,
    this.hintText,
    this.textEditingController,
    this.flexNumber,
    this.textInputType,
    this.onChangeFunction,
    this.validatorFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flexNumber,
      child: TextFormField(
        onChanged: onChangeFunction,
        key: globalKey,
        keyboardType: textInputType,
        style: TextStyle(
          fontSize: kPrimaryTextSize,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: kPrimaryTextSize,
          ),
        ),
        controller: textEditingController,
        validator: validatorFunction,
      ),
    );
  }
}
