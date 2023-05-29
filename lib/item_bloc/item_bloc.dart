import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_list/item_model.dart';
part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc()
      : super(ItemWithDataState(
          items: [],
          expandedHeight: 1.0,
        )) {
    on<AddItemEvent>(_onAddItemEvent);
    on<RemoveItemEvant>(_onRemoveItemEvant);
  }

  void _onAddItemEvent(ItemEvent event, Emitter<ItemState> emit) async {
    final state = this.state;

    if (state is ItemWithDataState) {
      final List<ItemModel> items = List.from(state.items);
      double expandedHeight = state.expandedHeight;

      emit(ItemLoadingState());

      items.add(ItemModel(title: ' ITEM: ${state.items.hashCode}'));

      if (items.length % 2 != 0) {
        expandedHeight -= 0.1;
      }

      if (Random().nextBool()) {
        emit(ItemErrorState(message: 'Failed to add item.'));
      }
      emit(ItemWithDataState(items: items, expandedHeight: expandedHeight));
    }
  }

  void _onRemoveItemEvant(ItemEvent event, Emitter<ItemState> emit) async {
    final state = this.state;

    if (state is ItemWithDataState) {
      final List<ItemModel> items = List.from(state.items);
      double expandedHeight = state.expandedHeight;

      emit(ItemLoadingState());

      if (items.isNotEmpty) {
        items.removeLast();

        if (items.length % 2 == 0) {
          expandedHeight += 0.1;
        }
      }

      if (Random().nextBool()) {
        emit(ItemErrorState(message: 'Failed to remove item.'));
      }
      emit(ItemWithDataState(items: items, expandedHeight: expandedHeight));
    }
  }
}
