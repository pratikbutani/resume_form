import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_form/constants/strings.dart';
import 'package:resume_form/extensions/widget_extensions.dart';
class RawAccountingExp extends StatelessWidget {
final  String title;
final Function(String) onValueChange;

  const RawAccountingExp({Key key, this.title, this.onValueChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title).paddingAll(8)),
        Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (str) {},
              maxLength: 3,
              maxLengthEnforced: false,
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  hintText: Strings.EXP_IN_MONTH,
                  counterText: '',
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
            ).paddingAll(5)),
      ],
    );
  }
}
