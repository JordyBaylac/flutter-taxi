import 'package:carousel_slider/carousel_slider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zitotaxi/services/screen_service.dart';
import 'package:zitotaxi/services/theme_service.dart';

class BookingSection extends StatefulWidget {
  @override
  _BookingSectionState createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  bool _showSection = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _showSection = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = screenHeightOf(context);
    final width = screenWidthOf(context);
    final boxHeight = height * .65;

    return SizedBox(
      height: boxHeight,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(seconds: 3),
            curve: Curves.elasticInOut,
            top: _showSection ? 0 : height + boxHeight,
            right: 0,
            left: 0,
            child: Container(
              width: width,
              height: boxHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    offset: Offset(0, -5),
                    color: Colors.black12,
                  ),
                ],
                color: colorSchemeOf(context).primaryVariant,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Book now!", style: Theme.of(context).primaryTextTheme.title),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Text(
                      "no payment required",
                      style: Theme.of(context).primaryTextTheme.subtitle.apply(color: Colors.black.withOpacity(.7)),
                    ),
                  ),
                  Expanded(flex: 1, child: _buildBookingBody()),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // return TweenAnimationBuilder(
    //   duration: Duration(seconds: 2),
    //   tween: Tween<double>(begin: .0, end: .5),
    //   child: new Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(50),
    //         topRight: Radius.circular(50),
    //       ),
    //       boxShadow: [
    //         BoxShadow(
    //           blurRadius: 15,
    //           offset: Offset(0, 0),
    //           color: Colors.black26,
    //         ),
    //       ],
    //       color: colorSchemeOf(context).primaryVariant,
    //     ),
    //     child: Row(
    //       children: <Widget>[
    //         Image.asset(
    //           "assets/cars/chevy56_2.png",
    //         ),
    //         Column(
    //           children: <Widget>[Text("Chevy 56"), Text("textoo")],
    //         )
    //       ],
    //     ),
    //   ),
    //   builder: (context, double screenFraction, child) {
    //     print("screenFraction: $screenFraction");
    //     print("calculated position: ${height * (1 - screenFraction)}");
    //     return Transform.translate(
    //       child: child,
    //       offset: Offset(0, height * (1 - screenFraction)),
    //     );
    //   },
    // );
  }

  _buildBookingBody() {
    final isLandscape = screenIsLandscape(context);

    // final image = Image.asset(
    //   "assets/cars/chevy56_2.png",
    //   fit: BoxFit.cover,
    // );

    final image = _buildCarsCarousel();

    final inputs = _buildBookingForm();

    if (isLandscape) {
      return Row(
        children: <Widget>[
          Expanded(child: image),
          Expanded(child: inputs),
        ],
      );
    }

    return Column(
      children: <Widget>[
        Expanded(child: image),
        Expanded(flex: 4, child: inputs),
      ],
    );
  }

  _buildCarsCarousel() {
    return Stack(
      children: [
        CarouselSlider(
          height: 400.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 10),
          pauseAutoPlayOnTouch: Duration(milliseconds: 100),
          initialPage: 1,
          items: cars().map((asset) {
            return Image.asset(
              asset,
              fit: BoxFit.fitWidth,
            );
          }).toList(),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white38.withOpacity(.05),
                Colors.white70,
              ],
              stops: [0.90, 1.0],
            ),
          ),
        ),
      ],
    );
  }

  _buildBookingForm() => Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                validator: Validator(entityName: "Your name").add(RequiredRule()).add(MinLengthRule(4)),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                validator: Validator(entityName: "Your email").add(RequiredRule()).add(EmailRule()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 3,
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
                  Spacer(),
                  Expanded(
                    flex: 3,
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
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                height: 10,
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
