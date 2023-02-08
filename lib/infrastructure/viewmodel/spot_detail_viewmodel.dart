import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:spots_discovery/data/dto/comment_dto.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/data/model/comment.dart';
import 'package:spots_discovery/data/model/spot.dart';
import 'package:spots_discovery/data/model/spot_details.dart';
import 'package:spots_discovery/ui/detail.dart';

class SpotDetailViewModel extends ChangeNotifier {
  final SpotEndpoint _spotEndpoint;
  SpotDetailViewModel(this._spotEndpoint) {
    _init();
  }

  Comment? comment;

  Future<void> _init() async {
    notifyListeners();
  }

  //post message
  Future<String> postComment(int id, String comment) async {
    this.comment = Comment(
        comment: comment, createdAt: DateTimeToTimestamp(DateTime.now()));
    final response =
        await _spotEndpoint.postComment(id, this.comment!.toJson());

    notifyListeners();

    return response.name ?? "";
  }

  int DateTimeToTimestamp(DateTime date) {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
