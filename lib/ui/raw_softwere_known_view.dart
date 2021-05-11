import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_form/constants/strings.dart';
import 'package:resume_form/extensions/widget_extensions.dart';
import 'package:resume_form/models/accounting_exp_model.dart';
import 'package:resume_form/models/software_model.dart';

class RawSoftwereKnownView extends StatelessWidget {
  final SoftwareModel softwareModel;
  final int index;
  final VoidCallback onRemoveClick;
  final Function(bool) onValueChange;

  const RawSoftwereKnownView(
      {Key key,
      this.softwareModel,
      this.index,
      this.onRemoveClick,
      this.onValueChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onValueChange(!softwareModel.isEnabled);
      },
      child: Row(
        children: [
          Expanded(child: Text(softwareModel.softwareName).paddingAll(8)),
          Checkbox(
            checkColor: Colors.black,
            activeColor: Colors.orange,
            value: softwareModel.isEnabled,
            onChanged: (bool value) {
              onValueChange(value);
              /*
              setState(() {
                this.showvalue = value;
              });
*/
            },
          ),
          /*  Expanded(
              child: TextFormField(
                initialValue: softwareModel.years == 0
                    ? ''
                    : softwareModel.years.toString(),
                keyboardType: TextInputType.number,
                onChanged: (str) {
                  if (str != '') {
                    onValueChange(double.parse(str));
                    //   softwareKnownList[index].percentage = double.parse(str);
                  }else{
                    onValueChange(0);
                  }
                },
                maxLength: 3,
                maxLengthEnforced: false,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintText: Strings.YEARS,
                    counterText: '',
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
              ).paddingAll(5)),*/
          Container(
            width: 40,
            child: Visibility(
              visible: softwareModel.isCancelable,
              child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    onRemoveClick();
/*
  softwareKnownList.removeAt(index);
                    setState(() {});

*/
                  }),
            ),
          )
        ],
      ),
    );
  }
}
