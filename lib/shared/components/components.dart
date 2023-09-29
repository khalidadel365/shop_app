import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color backgound = Colors.blue,
  bool isUpperCase = true,
  required String text,
  required VoidCallback onPressed,
  double radius = 15,
  bool isClickable = true,
}) => Container(
      width: width,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700

          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgound,
      ),
    );

Widget defaultFormField({required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChanged,
  FormFieldValidator? validate,
  required String? label,
  required IconData prefix,
  bool obsecureText = false,
  IconData? suffix,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  TextStyle? inputColor,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      controller: controller,
      //autovalidateMode: AutovalidateMode.always,
      keyboardType: type,
      obscureText: obsecureText,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      style: inputColor,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2.4,
              color: defaultColor), //<-- SEE HERE
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 2.4,
              color: Colors.grey.shade400), //<-- SEE HERE
              borderRadius: BorderRadius.circular(25.0),
        ),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
    );

  Widget myDivider() => Container(
    width: double.infinity,
    color: Colors.grey[300],
    height: 1.7,
  );
Widget defaultTextButton({required VoidCallback function, required String text}) => TextButton(
    onPressed: function,
    child: Text('${text.toUpperCase()}',
      style: TextStyle(
      fontSize: 12
    ),));

  void navigateTo (context,widget) => Navigator.push(
      context,
    MaterialPageRoute(
        builder: (context) => widget
    )
  );
void navigateAndFinish (context,widget) => Navigator.pushAndRemoveUntil(
    context,
  MaterialPageRoute(builder: (context) => widget),
        (route){
      return false;
    }
);

void showToast({required String message , required ToastStates state}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state) ,
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseToastColor(ToastStates state){
  Color color = Colors.green;
  switch(state){
    case ToastStates.SUCCESS :
      color = Colors.green;
    break;
    case ToastStates.ERROR :
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


