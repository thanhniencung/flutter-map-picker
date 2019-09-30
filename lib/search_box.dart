import 'package:flutter/material.dart';
import 'package:flutter_app_map_picker/location.dart';
import 'package:flutter_app_map_picker/picker_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  final PickerBloc bloc;
  SearchBox(this.bloc);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Tìm kiếm',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.7),
            ),
          ),
        ),
        noItemsFoundBuilder: (context) => SizedBox.shrink(),
        suggestionsCallback: (pattern) async {
          return await widget.bloc.search(pattern);
        },
        itemBuilder: (BuildContext context, Location location) {
          return Container(
            child: ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.redAccent,
              ),
              title: Container(
                margin: EdgeInsets.only(bottom: 7),
                child: Text(
                  location.name,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              subtitle: Text(location.formattedAddress),
            ),
          );
        },
        onSuggestionSelected: (Location location) {
          widget.bloc.locationSelected(location);
        },
      ),
    );
  }
}
