import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:spots_discovery/data/Manager/PreferenceManager.dart';
import 'package:spots_discovery/data/endpoint/spot_endpoint.dart';
import 'package:spots_discovery/infrastructure/viewmodel/home_viewmodel.dart';
import 'package:image_network/image_network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(SpotEndpoint(GetIt.I.get<Dio>())),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Spots"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Provider.of<HomeViewModel>(context, listen: false)
                        .navigateToFavorite(context);
                  },
                ),
              )
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 238, 238, 238),
            onPressed: () {
              final provider =
                  Provider.of<HomeViewModel>(context, listen: false);
              provider.navigateToDetail(context, provider.getRandom());
            },
            child: const Icon(
              Icons.shuffle,
              color: Color.fromARGB(255, 33, 38, 66),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 33, 38, 66),
          body: Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              print("favorites: ${viewModel.favorites}");
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.spots.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            onTap: () {
                              viewModel.navigateToDetail(
                                  context, viewModel.spots[index]);
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.favorite_border),
                              //check if spot id is equal to one of favorite ids
                              color: viewModel.favorites[
                                          viewModel.spots[index].id] ==
                                      true
                                  ? Colors.red
                                  : Colors.white,
                              onPressed: () async {
                                setState(() {
                                  viewModel
                                      .toggleFavorite(viewModel.spots[index]);
                                });
                              },
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                viewModel.spots[index].imageThumbnail!,
                                width: 64,
                                height: 64,
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/images/no_image.png",
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  );
                                },
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!
                                        : null,
                                  );
                                },
                              ),
                            ),
                            title: Text(
                              viewModel.spots[index].title!,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              viewModel.spots[index].mainCategory?.name ?? "",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 221, 221, 221),
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      lazy: true,
    );
  }
}
