import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:trader/data/data.dart';
import 'package:trader/data/repo/repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InformationScreen extends StatefulWidget {
  final History history;

  const InformationScreen({
    super.key,
    required this.history,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  late final TextEditingController nameController =
      TextEditingController(text: widget.history.currencyName);
  late final TextEditingController marginController =
      TextEditingController(text: widget.history.margin.toString());
  late final TextEditingController leverageController =
      TextEditingController(text: widget.history.leverage.toString());
  late final TextEditingController openPriceController =
      TextEditingController(text: widget.history.openedPrice.toString());
  late final TextEditingController closePriceController =
      TextEditingController(text: widget.history.closedPrice.toString());
  late final TextEditingController openedDateController =
      TextEditingController(text: widget.history.openedDate.toString());
  late final TextEditingController descriptionController =
      TextEditingController(text: widget.history.description);
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
   final localization = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text(localization.information , style: themeData.textTheme.bodyLarge!.copyWith(color: Colors.black , fontSize: 24) ,),
          backgroundColor: themeData.colorScheme.secondary,
          foregroundColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  marginController.text.isNotEmpty &&
                  leverageController.text.isNotEmpty &&
                  openPriceController.text.isNotEmpty &&
                  closePriceController.text.isNotEmpty &&
                  openedDateController.text.isNotEmpty) {
                widget.history.currencyName = nameController.text.toUpperCase();
                widget.history.margin = marginController.text;
                widget.history.leverage = leverageController.text;
                widget.history.openedPrice = openPriceController.text;
                widget.history.closedPrice = closePriceController.text;
                widget.history.openedDate = openedDateController.text;
                widget.history.description = descriptionController.text;
                final repository =
                    Provider.of<Repository<History>>(context, listen: false);
                repository.createOrUpdate(widget.history);
                Navigator.of(context).pop();
              } else {
                Fluttertoast.showToast(
                    msg: localization.toastMessage,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 2,
                    backgroundColor: themeData.colorScheme.secondary,
                    textColor: Colors.black,
                    fontSize: 16.0);
              }
            },
            label:  Text(localization.saveButton)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(
                height: 10,
              ),
              HistoryItem(
                maxLength: 20,
                controller: nameController,
                icon: const Icon(CupertinoIcons.bitcoin_circle_fill),
                width: MediaQuery.of(context).size.width,
                themeData: themeData,
                type: TextInputType.text,
                text:localization.nameHint ,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HistoryItem(
                    maxLength: 7,
                    controller: marginController,
                    icon: const Icon(CupertinoIcons.money_dollar_circle),
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    themeData: themeData,
                    type: TextInputType.number,
                    text: localization.margin,
                  ),
                  HistoryItem(
                    maxLength: 3,
                    controller: leverageController,
                    icon: const Icon(CupertinoIcons.bolt_circle),
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    themeData: themeData,
                    type: TextInputType.number,
                    text: localization.leverage,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HistoryItem(
                    maxLength: 7,
                    controller: openPriceController,
                    icon: const Icon(
                      CupertinoIcons.check_mark_circled,
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    themeData: themeData,
                    type: TextInputType.number,
                    text: localization.openPriceHint,
                  ),
                  HistoryItem(

                    maxLength: 7,
                    controller: closePriceController,
                    icon: const Icon(CupertinoIcons.xmark_circle),
                    width: MediaQuery.of(context).size.width / 2 - 15,
                    themeData: themeData,
                    type: TextInputType.number,
                    text: localization.closedPriceHint,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color:
                              themeData.colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () async {
                          DateTime? dateTime = await showOmniDateTimePicker(
                            context: context,
                            isShowSeconds: false,
                            is24HourMode: true,
                            isForce2Digits: true,
                            type: OmniDateTimePickerType.dateAndTime,
                          );

                          if (dateTime != null) {
                            openedDateController.text =
                                DateFormat('MM-dd-yyyy HH:mm').format(dateTime);

                            setState(() {});
                          }
                        },
                        child: Icon(
                          CupertinoIcons.calendar_badge_plus,
                          color: themeData.colorScheme.secondary,
                        ),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color(0xff1a1c1d),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(openedDateController.text,
                            style: TextStyle(
                                color: themeData.colorScheme.secondary)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: descriptionController,
                maxLength: 500,
                maxLines: 10,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff1a1c1d))),
                    filled: true,
                    fillColor: const Color(0xff1a1c1d),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffbcf246),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    label: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 320),
                      child: Text(
                        localization.description,
                        style: themeData.textTheme.bodySmall!
                            .copyWith(fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.themeData,
    required this.type,
    required this.text,
    required this.width,
    required this.icon,
    required this.controller,
    required this.maxLength,
  });

  final ThemeData themeData;
  final TextInputType type;
  final String text;
  final double width;
  final Widget icon;
  final TextEditingController controller;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 60,
      child: TextField(
        autofocus: false,
        
        keyboardType: type,
        maxLength: maxLength,
        controller: controller,
        cursorColor: Colors.white,
        maxLines: 1,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xff1a1c1d),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff1a1c1d))),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xffbcf246),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          label: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(text,
                style: themeData.textTheme.bodySmall!.copyWith(fontSize: 15)),
          ),
          prefixIcon: icon,
        ),
      ),
    );
  }
}
