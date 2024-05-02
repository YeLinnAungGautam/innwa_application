import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/util/constants.dart';

class CustomTextFormField extends StatefulWidget {
  final Function onSaved;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String label;
  final bool pass;
  final bool needBackground;
  final String? initialData;
  final Widget? prefix;
  const CustomTextFormField({
    super.key,
    required this.onSaved,
    this.onChanged,
    required this.label,
    required this.pass,
    required this.needBackground,
    this.validator,
    this.initialData,
    this.prefix,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscure = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleChange);
    if (widget.initialData != null) {
      debugPrint(
          "-----------pas---------------------initila ${widget.initialData}--------------------------------");
      _controller.text = widget.initialData!;
    }
  }

  void _handleChange() {
    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
  }

  final FocusScopeNode _node = FocusScopeNode();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: TextFormField(
        autofocus: false,
        controller: _controller,
        validator: widget.validator,
        obscureText: widget.pass ? _isObscure : false,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: widget.label,
            prefix: widget.prefix,
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: widget.needBackground ? 0 : 2, color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    width: widget.needBackground ? 0 : 2, color: Colors.black)),
            suffixIcon: widget.pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }
}
