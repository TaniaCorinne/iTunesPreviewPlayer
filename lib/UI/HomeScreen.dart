import 'package:flutter/material.dart';

import 'package:musicPlayerSearch_flutter/UI/SongListUI.dart';

import 'package:provider/provider.dart';

import '../Provider/SongProvider.dart';
import '../Model/SongModel.dart';

class SearchFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'Search field cannot be empty' : null;
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode;
  List<SongModel> songListResponse = List();
  bool _isLoading = false, _songListVisible = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(() async {
      var errorMessage;

      if (!_searchFocusNode.hasFocus) {
        // call for API
        if (SearchFieldValidator.validate(_searchController.text) == null) {
          setState(() {
            _isLoading = true;
          });
          try {
            songListResponse = await Provider.of<SongProvider>(context, listen: false)
                .retrieveSongList(_searchController.text);

            if (songListResponse.length == 0) {
              errorMessage =
                  'Sorry! We don\'t have anything that matches artist name you have asked for';
              _showErrorDialog(errorMessage);
            }

            setState(() {
              _isLoading = false;
              _songListVisible = true;
            });
          } catch (error) {
            _showErrorDialog(error.toString());
            print(error.toString());
          }
        }
        else{
          _showErrorDialog(SearchFieldValidator.validate(_searchController.text));
        }
        
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Artist',
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              focusNode: _searchFocusNode,
              keyboardType: TextInputType.name,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : Visibility(
                    visible: _songListVisible,
                    child: SongListUI(
                      musicList: songListResponse,
                    ),
                  ),
          ],
        ));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]),
    );
  }
}
