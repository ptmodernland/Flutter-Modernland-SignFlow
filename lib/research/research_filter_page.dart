import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterPage extends StatefulWidget {
  //for saving shared pref key
  final String? sharedPrefKey;

  const FilterPage({super.key, this.sharedPrefKey});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late DateTime _startDate = DateTime.now();
  late DateTime _endDate = DateTime.now();
  bool _isDateStartSelected = false;
  bool _isDateEndSelected = false;
  String _keywordSearch = "";
  TextEditingController _keywordController = TextEditingController();

  // Show the modal that contains the CupertinoDatePicker
  void _showDatePicker(context, {required bool isStartDate}) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    var tempDate = DateTime.now();
    showCupertinoModalPopup(
      context: context,
      builder: (_) => ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        // Adjust the radius as needed
        child: Container(
          height: 275,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      // Set the mode to show only the date
                      initialDateTime: isStartDate ? _startDate : _endDate,
                      minimumDate: isStartDate ? null : _startDate,
                      maximumDate: null,
                      // Set maximum date if needed
                      showDayOfWeek: false,
                      onDateTimeChanged: (val) {
                        tempDate = val;

                        setState(() {
                          // _isDateRangeSelected = true;
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            if (isStartDate) {
                              _startDate = tempDate;
                              if (_endDate.isBefore(_startDate)) {
                                // Reset endDate if it's newer than startDate
                                _endDate = _startDate;
                              }
                              _isDateStartSelected = true;
                            } else {
                              _endDate = tempDate;
                              if (_startDate.isAfter(_endDate)) {
                                _startDate = _endDate;
                              }
                              _isDateEndSelected = true;
                            }
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Apply Filter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearDateRange() {
    setState(() {
      // _startDate = DateTime.now();
      // _endDate = DateTime.now();
      // _isDateRangeSelected = false;
      _clearEndDate();
      _clearStartDate();
    });
  }

  void _clearEndDate() {
    setState(() {
      _startDate = DateTime.now();
      _endDate = DateTime.now();
      _isDateEndSelected = false;
    });
  }

  void _clearStartDate() {
    setState(() {
      _startDate = DateTime.now();
      _endDate = DateTime.now();
      _isDateStartSelected = false;
    });
  }

  void _clearQuerySearch() {
    setState(() {
      _keywordController.clear();
      _keywordSearch = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  _showDatePicker(context, isStartDate: true);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Select Start Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _showDatePicker(context, isStartDate: false);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Select End Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Keyword",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CupertinoTextField(
                    controller: _keywordController,
                    placeholder: 'Enter query/keyword',
                    style: TextStyle(fontSize: 16.0),
                    onChanged: (value) {
                      setState(() {
                        _keywordSearch = value;
                      });
                    },
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    prefix: Visibility(
                      visible: _keywordController.text.isNotEmpty,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.clear_circled),
                            onPressed: () {
                              setState(() {
                                _keywordController.clear();
                                _keywordSearch = "";
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Wrap(
                spacing: 2.0, // horizontal spacing between chips
                runSpacing: 0, // vertical spacing between lines of chips
                children: [
                  if (_isDateStartSelected)
                    InputChip(
                      label: Text(
                        'Start Date : '
                        '${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year.toString()}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blue,
                      deleteIcon: Icon(Icons.close, color: Colors.white),
                      onDeleted: _clearStartDate,
                    ),
                  if (_isDateEndSelected)
                    InputChip(
                      label: Text(
                        'End Date : '
                        '${_endDate.day.toString().padLeft(2, '0')}/${_endDate.month.toString().padLeft(2, '0')}/${_endDate.year.toString()}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blue,
                      deleteIcon: Icon(Icons.close, color: Colors.white),
                      onDeleted: _clearEndDate,
                    ),
                  if (_keywordSearch.isNotEmpty)
                    InputChip(
                      label: Text(
                        _keywordSearch,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blue,
                      deleteIcon: Icon(Icons.close, color: Colors.white),
                      onDeleted: _clearQuerySearch,
                    ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    var debug = _startDate.toString() +
                        _endDate.toString() +
                        _keywordController.text;
                    Fluttertoast.showToast(msg: debug);
                    var sharedPrefKey = this.widget.sharedPrefKey.toString();

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var eachKey = sharedPrefKey +
                        '_eachAttribute'; // Example key with sharedPrefKey followed by each attribute

                    // Save eachKey with the desired value
                    await prefs.setString(eachKey,
                        'value'); // Replace 'value' with the actual value you want to save

                    // Retrieve the saved value
                    var savedValue = prefs.getString(eachKey);
                    print(savedValue);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Apply Filter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
