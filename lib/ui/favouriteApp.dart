import 'package:favourite_app_using_bloc/bloc/favourite_bloc.dart';
import 'package:favourite_app_using_bloc/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteApp extends StatefulWidget {
  const FavouriteApp({super.key});

  @override
  State<FavouriteApp> createState() => _FavouriteAppState();
}

class _FavouriteAppState extends State<FavouriteApp> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite App"),
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteItemStates>(
            buildWhen: (previous, current) =>
                previous.tempFavouriteItemList != current.tempFavouriteItemList,
            builder: (context, state) {
              return Visibility(
                visible: state.tempFavouriteItemList.isNotEmpty ? true : false,
                child: IconButton(
                    onPressed: () {
                      context.read<FavouriteBloc>().add(DeleteItem());
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<FavouriteBloc, FavouriteItemStates>(
            builder: (context, state) {
          switch (state.listStatus) {
            case ListStatus.loading:
              return const CircularProgressIndicator();
            case ListStatus.failure:
              return const Text("SomeThing Went Wrong");
            case ListStatus.success:
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.favouriteItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.favouriteItemList[index];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                            value: state.tempFavouriteItemList.contains(item)
                                ? true
                                : false,
                            onChanged: (value) {
                              if (value!) {
                                context
                                    .read<FavouriteBloc>()
                                    .add(SelectItem(item: item));
                              } else {
                                context
                                    .read<FavouriteBloc>()
                                    .add(UnSelectItem(item: item));
                              }
                            }),
                        title: Text(item.value.toString()),
                        trailing: IconButton(
                            onPressed: () {
                              FavouriteItemModel itemModel = FavouriteItemModel(
                                  id: item.id,
                                  value: item.value,
                                  isFavourite: item.isFavourite ? false : true);
                              context
                                  .read<FavouriteBloc>()
                                  .add(FavouriteItem(item: itemModel));
                            },
                            icon: Icon(item.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline)),
                      ),
                    );
                  });
            default:
              return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
