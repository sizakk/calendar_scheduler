import 'package:calendar_scheduler/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.isTime,
    required this.label,
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w600),
        ),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField(){
    return TextFormField(
      onSaved: onSaved,
      validator: (String? val){
        if(val == null || val.isEmpty){
          return 'Input Values';
        }

        if(isTime){
          int time = int.parse(val!);

          if(time < 0){
            return 'bigger than 0';
          }
          if(time > 24){
            return 'less than 24';
          }
        }else{

        }

        return null;
      },
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime
          ? [
        FilteringTextInputFormatter.digitsOnly,
      ]
          : [],
      maxLines: isTime ? 1 : null,
      expands: isTime ? false : true,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300]),
    );
  }

}
