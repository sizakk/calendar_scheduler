import 'package:calendar_scheduler/component/customTextField.dart';
import 'package:calendar_scheduler/constant/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height / 2 + bottomInset,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Time(),
              SizedBox(height: 16),
              _Content(),
              SizedBox(height: 16),
              _ColorPicker(),
              SizedBox(height: 8),
              _SaveButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '시작 시간',
        )),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: CustomTextField(
          label: '마감 시간',
        ))
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: '내용',
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
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_COLOR
            ),
            child: Text('SAVE'),
          ),
        ),
      ],
    );
  }
}
