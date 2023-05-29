part of 'item_bloc.dart';

abstract class ItemState {}

class ItemInitialState extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemErrorState extends ItemState {
  ItemErrorState({required this.message});
  final String message;
}

class ItemWithDataState extends ItemState {
  ItemWithDataState({
    required this.items,
    required this.expandedHeight,
  });

  final List<ItemModel> items;
  final double expandedHeight;
}
