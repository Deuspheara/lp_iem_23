import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/infrastructure/viewmodel/favorite_viewmodel.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteViewModel>(
      create: (context) => FavoriteViewModel(SpotEndpoint(GetIt.I.get<Dio>())),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Favorites"),
          ),
          body: Consumer<FavoriteViewModel>(
            builder: (context, viewModel, child) {
              return ListView.builder(
                itemCount: viewModel.spots.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(viewModel.spots[index].title ?? ""),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          viewModel.spots[index].imageFullsize ?? "",
                          width: 64,
                          height: 64,
                          fit: BoxFit.fitWidth,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      subtitle: Text(viewModel.spots[index].address ?? ""),
                      onTap: () {
                        viewModel.navigateToDetail(
                            context, viewModel.spots[index]);
                      },
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          viewModel.toggleFavorite(viewModel.spots[index]);
                        },
                      ));
                },
              );
            },
          ),
        );
      },
    );
  }
}
