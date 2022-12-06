import 'package:calendar_scheduler/component/customTextField.dart';
import 'package:calendar_scheduler/constant/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery
        .of(context)
        .viewInsets
        .bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (String? val){
                        startTime = int.parse(val!);
                      },
                      onEndSaved: (String? val){
                        endTime = int.parse(val!);
                      },
                    ),
                    SizedBox(height: 16),
                    _Content(
                      onSaved: (String? val){
                        content = val;
                      },
                    ),
                    SizedBox(height: 16),
                    _ColorPicker(),
                    SizedBox(height: 8),
                    _SaveButton(
                      onPressed: onSavePressed,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      print('no erroe');
      formKey.currentState!.save();

    } else {
      print('error');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
              label: '시작 시간',
              isTime: true,
              onSaved:onStartSaved,)),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: CustomTextField(
              label: '마감 시간',
              isTime: true,
              onSaved:onEndSaved,
            ))
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Content({
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved:onSaved,
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      spacing: 8,
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      height: 32.0,
      width: 32.0,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
            child: Text('SAVE'),
          ),
        ),
      ],
    );
  }
}
