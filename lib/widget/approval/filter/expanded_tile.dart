import 'package:flutter/material.dart';

class ExpandedTile extends StatefulWidget {
  @override
  _ExpandedTileState createState() => _ExpandedTileState();
}

class _ExpandedTileState extends State<ExpandedTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 2,
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          backgroundColor: Colors.white,
          title: _buildTitle(),
          shape: Border(),
          trailing: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
          onExpansionChanged: (bool expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text("Welcome"),
                  Spacer(),
                  Icon(Icons.check),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text("Course Menu"),
                  Spacer(),
                  Icon(Icons.check),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("MODULE 1"),
            Spacer(),
            Icon(
              _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          ],
        ),
        Text("Course Overview"),
        Row(
          children: <Widget>[
            Text("6 Tasks"),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () {},
              icon: Icon(Icons.play_arrow),
              label: Text("Continue"),
            )
          ],
        ),
      ],
    );
  }
}
