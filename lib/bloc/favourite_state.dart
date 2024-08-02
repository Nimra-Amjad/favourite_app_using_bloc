part of 'favourite_bloc.dart';

enum ListStatus { loading, success, failure }

sealed class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

final class FavouriteInitial extends FavouriteState {}

class FavouriteItemStates extends Equatable {
  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> tempFavouriteItemList;
  final ListStatus listStatus;

  const FavouriteItemStates(
      {this.favouriteItemList = const [],
      this.tempFavouriteItemList = const [],
      this.listStatus = ListStatus.loading});

  FavouriteItemStates copyWith(
      {final List<FavouriteItemModel>? favouriteItemList,
      final List<FavouriteItemModel>? tempFavouriteItemList,
      final ListStatus? listStatus}) {
    return FavouriteItemStates(
        favouriteItemList: favouriteItemList ?? this.favouriteItemList,
        tempFavouriteItemList:
            tempFavouriteItemList ?? this.tempFavouriteItemList,
        listStatus: listStatus ?? this.listStatus);
  }

  @override
  List<Object?> get props =>
      [favouriteItemList, tempFavouriteItemList, listStatus];
}
