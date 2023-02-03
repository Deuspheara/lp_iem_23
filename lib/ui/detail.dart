import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/model/spot.dart';
import '../data/model/spot_detail.dart';

class SpotDetailPage extends StatelessWidget {
  final Spot spot;
  final SpotDetail spotDetail;

  const SpotDetailPage({required this.spot, required this.spotDetail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(spot.title ?? ""),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 250,
            child: PageView.builder(
              itemCount: spotDetail.imagesCollection?.length ?? 0,
              itemBuilder: (ctx, i) => Image.network(
                spotDetail.imagesCollection?[i] ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (spot.isClosed == true) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
              spot.address ?? "",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (spot.trainStation != null) ...[
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
                    spot.trainStation ?? "",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ],
          if (spot.isRecommended == true) ...[
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                'Recommandé',
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            )
          ],
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Catégories',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          ListView.builder(
            itemCount: spot.tagsCategory?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (ctx, i) => ListTile(
                title: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(spot.tagsCategory![i].name ?? ""),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
