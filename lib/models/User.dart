/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs

import 'ModelProvider.dart';

/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const UserType();
  final String id;
  final String name;
  final List<Post> posts;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const User._internal({@required this.id, @required this.name, this.posts});

  factory User({String id, @required String name, List<Post> posts}) {
    return User._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        posts: posts != null ? List.unmodifiable(posts) : posts);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        name == other.name &&
        DeepCollectionEquality().equals(posts, other.posts);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name");
    buffer.write("}");

    return buffer.toString();
  }

  User copyWith({String id, String name, List<Post> posts}) {
    return User(
        id: id ?? this.id, name: name ?? this.name, posts: posts ?? this.posts);
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        posts = json['posts'] is List
            ? (json['posts'] as List)
                .map((e) => Post.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posts': posts?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField POSTS = QueryField(
      fieldName: "posts",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Post).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.POSTS,
        isRequired: false,
        ofModelName: (Post).toString(),
        associatedKey: Post.USER));
  });
}

class UserType extends ModelType<User> {
  const UserType();

  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}
