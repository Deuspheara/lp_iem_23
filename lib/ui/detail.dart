import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/data/extensions/HexColor.dart';
import 'package:spots_discovery/data/model/comment.dart';
import 'package:spots_discovery/infrastructure/viewmodel/spot_detail_viewmodel.dart';
import 'package:spots_discovery/ui/components/minimalistic_textfield.dart';
import '../data/model/spot.dart';
import 'package:spots_discovery/data/model/spot_details.dart';

import 'components/comment.dart';

class SpotDetailPage extends StatefulWidget {
  final Spot spot;
  final SpotDetail spotDetail;

  SpotDetailPage({required this.spot, required this.spotDetail, Key? key})
      : super(key: key);

  @override
  _SpotDetailPageState createState() => _SpotDetailPageState();
}

class _SpotDetailPageState extends State<SpotDetailPage> {
  String _comment = "";
  final ScrollController _controller = ScrollController();

  final TextEditingController _textEditingController = TextEditingController();

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent + 50,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SpotDetailViewModel>(
      create: (context) =>
          SpotDetailViewModel(SpotEndpoint(GetIt.I.get<Dio>())),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.spot.title ?? ""),
          ),
          body: Consumer<SpotDetailViewModel>(
              builder: (context, viewModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 250,
                  child: PageView.builder(
                    itemCount: widget.spotDetail.imagesCollection?.length ?? 0,
                    itemBuilder: (ctx, i) => Image.network(
                        widget.spotDetail.imagesCollection?[i] ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, error, stackTrace) => Image.asset(
                              'assets/images/no_image.png',
                              fit: BoxFit.cover,
                            )),
                  ),
                ),
                if (widget.spot.isClosed == true) ...[
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    color: Colors.red,
                    child: Text(
                      'Fermé',
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  )
                ] else ...[
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    color: Colors.green,
                    child: Text(
                      'Ouvert',
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.spot.address ?? "",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (widget.spot.trainStation != null) ...[
                  Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.train,
                          color: Colors.black,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.spot.trainStation ?? "",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ],
                if (widget.spot.isRecommended == true) ...[
                  Container(
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      'Recommandé',
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Catégories',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.spot.tagsCategory?.length ?? 0,
                    itemBuilder: (ctx, i) => SizedBox(
                      width: 150,
                      child: ListTile(
                          title: Container(
                        decoration: BoxDecoration(
                          color: HexColor.fromHex(
                              (widget.spot.tagsCategory?[i].color ??
                                  "#000000")),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.spot.tagsCategory?[i].name ?? ""),
                        ),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Commentaires',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      controller: _controller,
                      itemCount: widget.spotDetail.comments?.length ?? 0,
                      itemBuilder: (ctx, i) {
                        String key =
                            widget.spotDetail.comments!.keys.elementAt(i);
                        return CommentWidget(
                          comment:
                              widget.spotDetail.comments?[key]?.comment ?? "",
                          createdAt:
                              widget.spotDetail.comments?[key]?.createdAt ?? 0,
                          key: ValueKey(key),
                        );
                      }),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: MinimalTextField(
                          controller: _textEditingController,
                          hintText: "Ajouter un commentaire",
                          onChanged: (value) {
                            _comment = value;
                          },
                        ),
                      ),
                    ),
                    //send
                    Container(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 16.0),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (widget.spotDetail.id != null) {
                            //get response and print it
                            viewModel
                                .postComment(widget.spotDetail.id!, _comment)
                                .then((value) {
                              setState(() {
                                widget.spotDetail.comments?.addAll({
                                  value: Comment(
                                      comment: _comment,
                                      createdAt:
                                          DateTime.now().millisecondsSinceEpoch)
                                });
                                _scrollDown();
                                _textEditingController.clear();
                              });
                            });
                          }
                        },
                      ),
                    )

                    //send button
                  ],
                )
              ],
            );
          }),
        );
      },
    );
  }
}
