import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flrx_validator/flrx_validator.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final boxHeight = screenIsLandscape(context) ? height * .55 : height * .60;
    final boxWidth = screenIsLandscape(context) ? width * .30 : width;

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        TweenAnimationBuilder(
          duration: Duration(seconds: 1),
          curve: Curves.elasticInOut,
          tween: Tween<double>(begin: 0, end: boxHeight),
          builder: (context, double boxFraction, child) {
            return Positioned(
              top: height - boxFraction.toInt(),
              width: boxWidth,
              right: 0,
              child: child,
            );
          },
          child: Container(
            height: boxHeight,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
              color: colorSchemeOf(context).primaryVariant,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Book now!", style: Theme.of(context).primaryTextTheme.title),
                          Spacer(),
                          Text(
                            "no payment required",
                            style:
                                Theme.of(context).primaryTextTheme.subtitle.apply(color: Colors.black.withOpacity(.7)),
                          ),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: _buildBookingBody()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildBookingBody() {
    final isLandscape = screenIsLandscape(context);

    final inputs = _buildBookingForm();

    if (isLandscape) {
      return Row(
        children: <Widget>[
          Expanded(child: inputs),
        ],
      );
    }

    return Column(
      children: <Widget>[
        Expanded(flex: 7, child: inputs),
      ],
    );
  }

  _buildBookingForm() => Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            padding: EdgeInsets.all(screenIsLandscape(context) ? 10 : 0),
            children: <Widget>[
              Row(
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
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      validator: Validator(entityName: "Your name").add(RequiredRule()).add(MinLengthRule(4)),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: DateTimeField(
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(labelText: "Date"),
                      // initialValue: DateTime.now(),
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.datetime,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                      },
                      onChanged: (date) {
                        print("selected date $date");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      validator: Validator(entityName: "Your email").add(RequiredRule()).add(EmailRule()),
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
                      decoration: InputDecoration(
                        labelText: "2 travelers",
                      ),
                      // value: "2",
                      isExpanded: true,
                      isDense: true,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          print("number of people $newValue");
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Origin"),
                      validator: Validator(entityName: "Point of origin").add(RequiredRule()).add(MinLengthRule(4)),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Destination"),
                      validator: Validator(entityName: "Desired destination").add(RequiredRule()).add(MinLengthRule(4)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: (screenIsLandscape(context) ? 10 : 5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(),
                    RaisedButton(
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
                            Text('Get Quote'),
                            SizedBox(width: 10),
                            Icon(Icons.local_taxi),
                          ],
                        ),
                      ),
                    ),
                    !screenIsLandscape(context)
                        ? Spacer()
                        : SizedBox(
                            width: 0,
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
              ),
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
