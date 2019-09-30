import 'package:flutter/material.dart';
import 'package:flutter_app_map_picker/map_picker.dart';
import 'package:flutter_app_map_picker/picker_bloc.dart';
import 'package:flutter_app_map_picker/search_box.dart';
import 'package:provider/provider.dart';

class MapPickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Picker'),
      ),
      body: ChangeNotifierProvider<PickerBloc>(
        builder: (context) => PickerBloc.getInstance(),
        child: MapPickerBody(),
      ),
    );
  }
}

class MapPickerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PickerBloc>(
      builder: (context, bloc, child) => Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                MapPicker(bloc),
                SearchBox(bloc),
              ],
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PickerBloc pickerBloc = Provider.of<PickerBloc>(context);
    return Container(
      height: 90,
      width: double.infinity,
      color: Colors.blue[50],
      child: FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.5,
        child: RaisedButton(
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {
            Navigator.pop(context, pickerBloc.currentLocation);
          },
          child: Text(
            "Chọn",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
