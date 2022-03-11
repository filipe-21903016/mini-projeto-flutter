import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class CustomRadioButton extends StatefulWidget {
  final bool isSelected;
  final String text;

  const CustomRadioButton({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isSelected) {
      return SelectedRadio(
        text: widget.text,
      );
    }
    else {
      return UnselectedRadio(
        text: widget.text,
      );
    }
  }
}

class SelectedRadio extends StatelessWidget {
  final String text;

  const SelectedRadio({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: <Color>[Color(0xFF6FB1FF), Color(0xFF93A4FF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0XFFF4F9FF),
                fontSize: 18
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UnselectedRadio extends StatelessWidget {
  final String text;

  const UnselectedRadio({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0XFFF4F9FF),
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
        child: Center(
          child: GradientText(
            text,
            style: const TextStyle(
              fontSize: 18
            ),
            gradient: const LinearGradient(
                colors: <Color>[Color(0xFF6FB1FF), Color(0xFF93A4FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
    );
  }
}
