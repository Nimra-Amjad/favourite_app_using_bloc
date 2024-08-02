import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favourite_app_using_bloc/model/favourite_item_model.dart';
import 'package:favourite_app_using_bloc/repository/favourite_repo.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteItemStates> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> tempFavouriteList = [];

  FavouriteRepository favouriteRepository;
  FavouriteBloc(this.favouriteRepository) : super(const FavouriteItemStates()) {
    on<FetchFavouriteList>(fetchList);
    on<FavouriteItem>(addFavouriteItemList);
    on<SelectItem>(selectItem);
    on<UnSelectItem>(unSelectItem);
    on<DeleteItem>(deleteItem);
  }

  void fetchList(
      FetchFavouriteList event, Emitter<FavouriteItemStates> emit) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.success));
  }

  void addFavouriteItemList(
      FavouriteItem event, Emitter<FavouriteItemStates> emit) async {
    final index =
        favouriteList.indexWhere((element) => element.id == event.item.id);

    if (event.item.isFavourite) {
      if (tempFavouriteList.contains(favouriteList[index])) {
        tempFavouriteList.remove(favouriteList[index]);
        tempFavouriteList.add(event.item);
      }
    } else {
      if (tempFavouriteList.contains(favouriteList[index])) {
        tempFavouriteList.remove(favouriteList[index]);
        tempFavouriteList.add(event.item);
      }
    }

    favouriteList[index] = event.item;

    emit(state.copyWith(
        favouriteItemList: List.from(favouriteList),
        tempFavouriteItemList: List.from(tempFavouriteList)));
  }

  void selectItem(SelectItem event, Emitter<FavouriteItemStates> emit) async {
    tempFavouriteList.add(event.item);
    emit(state.copyWith(tempFavouriteItemList: List.from(tempFavouriteList)));
  }

  void unSelectItem(
      UnSelectItem event, Emitter<FavouriteItemStates> emit) async {
    tempFavouriteList.remove(event.item);
    emit(state.copyWith(tempFavouriteItemList: List.from(tempFavouriteList)));
  }

  void deleteItem(DeleteItem event, Emitter<FavouriteItemStates> emit) async {
    for (int i = 0; i < tempFavouriteList.length; i++) {
      favouriteList.remove(tempFavouriteList[i]);
    }
    tempFavouriteList.clear();
    emit(state.copyWith(
        favouriteItemList: List.from(tempFavouriteList),
        tempFavouriteItemList: List.from(tempFavouriteList)));
  }
}
