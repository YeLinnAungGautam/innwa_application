import 'package:flutter/material.dart';
import 'package:innwa_mobile_dev/util/constants.dart';


class CustomTextFormField extends StatefulWidget {
  
  final Function onSaved;
  final Function(String)? onChanged;
  final String label;
  final bool pass;
  final bool needBackground;
  const CustomTextFormField({super.key,required this.onSaved,this.onChanged,required this.label,required this.pass,required this.needBackground});

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
  }

   void _handleChange() {
    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextFormField(
        controller: _controller,
        obscureText: widget.pass ? _isObscure : false,
        decoration: InputDecoration(
            filled: widget.needBackground,
            fillColor: inputBackground,
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: kTextFieldColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:  BorderSide(width: widget.needBackground ? 0 : 2, color: backgroundColorLight)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: widget.needBackground ? 0 : 2, color: backgroundColorLight)),
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