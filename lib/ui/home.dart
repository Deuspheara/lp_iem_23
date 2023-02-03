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
  //tableau favoris color
  final favoriteColor = <int, bool>{};

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(SpotEndpoint(GetIt.I.get<Dio>())),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Spots"),
          ),
          backgroundColor: const Color.fromARGB(255, 33, 38, 66),
          body: Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              print(viewModel.spots.length);
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
                              icon: Icon(Icons.favorite_border),
                              color: favoriteColor[index] ?? false
                                  ? Colors.red
                                  : Colors.white,
                              onPressed: () async {
                                if (await SharedPreferenceManager.isFavSpot(
                                    viewModel.spots[index].id)) {
                                  SharedPreferenceManager.removeFavSpot(
                                      viewModel.spots[index].id);
                                  setState(() {
                                    favoriteColor[index] = false;
                                  });

                                  print("remove");
                                } else {
                                  SharedPreferenceManager.addFavSpot(
                                      viewModel.spots[index].id);
                                  setState(() {
                                    favoriteColor[index] = true;
                                  });
                                  print("add");
                                }
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
                  )
                ],
              );
            },
          ),
        );
      },
      lazy: false,
    );
  }
}
