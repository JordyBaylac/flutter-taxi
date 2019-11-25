import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:zitotaxi/services/screen_service.dart';
import 'package:zitotaxi/services/theme_service.dart';

class BookingSection extends StatefulWidget {
  @override
  _BookingSectionState createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = screenHeightOf(context);
    final width = screenWidthOf(context);
    final boxHeight = screenIsLandscape(context) ? height * .30 : height * .40;
    final boxWidth = width;
    final buttonSectionHeight = height * .18;

    return Expanded(
      child: Container(
        color: colorSchemeOf(context).primaryVariant,
        child: Stack(
          children: <Widget>[
            TweenAnimationBuilder(
              duration: Duration(seconds: 1),
              curve: Curves.elasticInOut,
              tween: Tween<double>(begin: -boxHeight, end: buttonSectionHeight),
              builder: (context, double boxFraction, child) {
                return Positioned(
                  bottom: boxFraction,
                  width: boxWidth,
                  height: boxHeight,
                  right: 0,
                  child: child,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenIsLandscape(context) ? 100 : 25),
                child: SingleChildScrollView(
                  child: _buildBookingForm(),
                ),
              ),
            ),
            TweenAnimationBuilder(
              duration: Duration(seconds: 1),
              curve: Curves.easeInSine,
              tween: Tween<double>(begin: -buttonSectionHeight, end: 5),
              builder: (context, double boxFraction, child) {
                return Positioned(
                  bottom: boxFraction,
                  width: boxWidth,
                  height: buttonSectionHeight,
                  right: 0,
                  child: child,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: _buildBookButton(),
                    ),
                    Text(
                      "no payment is required",
                      style: Theme.of(context).primaryTextTheme.subtitle.apply(color: Colors.black.withOpacity(.7)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//padding: EdgeInsets.all(screenIsLandscape(context) ? 10 : 0),
  _buildBookingForm() => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Airport pickup:", style: primaryTextThemeOf(context).display2),
                      Switch(
                        onChanged: (v) {
                          print("v is $v");
                        },
                        value: false,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField(
                    items: ['1', '2', '3', '4', "5 to 9", "9 or more"].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(border: InputBorder.none),
                    // value: "2",
                    icon: Icon(Icons.people),
                    isExpanded: true,
                    // isDense: true,
                    iconSize: 18,
                    elevation: 16,
                    hint: Text(
                      "2 travelers",
                      style: primaryTextThemeOf(context).body2,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        print("number of people $newValue");
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Origin"),
                    validator: Validator(entityName: "Point of origin").add(RequiredRule()).add(MinLengthRule(4)),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Destination"),
                    validator: Validator(entityName: "Desired destination").add(RequiredRule()).add(MinLengthRule(4)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: DateTimeField(
                    format: intl.DateFormat("yyyy-MM-dd HH:mm"),
                    decoration: InputDecoration(labelText: "Date and time"),
                    // initialValue: DateTime.now(),
                    enableInteractiveSelection: false,
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                    onChanged: (date) {
                      print("selected date $date");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  _buildBookButton() => RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: colorSchemeOf(context).secondary,
        onPressed: () {
          // Validate returns true if the form is valid, or false
          // otherwise.
          if (_formKey.currentState.validate()) {
            // If the form is valid, display a Snackbar.
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: (screenIsLandscape(context) ? 15 : 10)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Continue'),
              SizedBox(width: 10),
              Icon(Icons.local_taxi),
            ],
          ),
        ),
      );
}

List<String> cars() {
  return [
    "assets/cars/chevy56_2.png",
    "assets/cars/chevy56.png",
    "assets/cars/blue_1.png",
    "assets/cars/blue_2.png",
  ];
}
