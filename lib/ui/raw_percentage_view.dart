import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_form/constants/strings.dart';
import 'package:resume_form/extensions/widget_extensions.dart';
import 'package:resume_form/models/accounting_exp_model.dart';
import 'package:resume_form/models/software_model.dart';

class RawPercentageView extends StatelessWidget {
  final AccountingExpModel softwareModel;
  final int index;
  final VoidCallback onRemoveClick;
  final Function(int) onValueChange;

  const RawPercentageView(
      {Key key,
      this.softwareModel,
      this.index,
      this.onRemoveClick,
      this.onValueChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(softwareModel.softwareName).paddingAll(8)),
        Expanded(
            child: TextFormField(
          initialValue: softwareModel.years == 0
              ? ''
              : softwareModel.years.toString(),
          keyboardType: TextInputType.number,
          onChanged: (str) {
            if (str != '') {
              onValueChange(int.parse(str));
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
        ).paddingAll(5)),
/*
        Visibility(
          visible: softwareModel.isCancelable,
          child: IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
              onPressed: () {
                onRemoveClick();
                */
/*  softwareKnownList.removeAt(index);
                setState(() {});
              *//*

              }),
        )
*/
      ],
    );
  }
}
