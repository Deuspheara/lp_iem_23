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

  CommentDto? comment;

  Future<void> _init() async {
    notifyListeners();
  }

  //post message
  Future<String> postComment(int id, String comment) async {
    print("postComment: $id, $comment");
    final response = await _spotEndpoint.postComment(
        id,
        Comment(
                comment: comment,
                createdAt: DateTimeToTimestamp(DateTime.now()))
            .toJson());
    print("created_at: ${DateTimeToTimestamp(DateTime.now())}");

    if (response.name != null) {
      this.comment = response;
    }

    notifyListeners();

    return response.name ?? "";
  }

  int DateTimeToTimestamp(DateTime date) {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
