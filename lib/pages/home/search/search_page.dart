import 'package:flutter/material.dart';
import 'package:social_media_app/components/card/user_card.dart';
import 'package:social_media_app/components/form/my_text_form_field.dart';
import 'package:social_media_app/models/User.dart';
import 'package:social_media_app/services/data_store/user_service.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller;
  Future<List<dynamic>> _searchResults;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildResultsWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: MyTextFormField(controller: _controller,),
        ),
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _searchResults = UserService.searchUser(_controller.text);
              });
            },
        ),
      ],
    );
  }

  Widget _buildResultsWidget() {
    return FutureBuilder(
      future: _searchResults,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          List<dynamic> searchResults = snapshot.data;
          if(searchResults.length == 0) {
            return Center(
              child: Text('No results found'),
            );
          }
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              if(searchResults[index] is User) {
                return UserCard(
                  user: searchResults[index],
                );
              }
              throw Exception('Unknown type ${searchResults[index].runtimeType}');
            },
          );
        }
        return Container();
      },
    );
  }
}
