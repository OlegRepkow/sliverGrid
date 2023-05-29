import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_list/app_dimmens.dart';
import 'package:grid_list/extensions/show_loading_indicator.dart';
import 'package:grid_list/item_bloc/item_bloc.dart';
import 'package:grid_list/item_model.dart';

class ItemsScreenPage extends StatefulWidget {
  const ItemsScreenPage({super.key});

  @override
  State<ItemsScreenPage> createState() => _ItemsScreenPageState();
}

void showErrorSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.fixed,
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class _ItemsScreenPageState extends State<ItemsScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemLoadingState) {
            context.showLoadingIndicator(
              alertTitle: "Loading",
            );
            Future.delayed(AppDimens.loadingIndicatorDuration,
                () => Navigator.pop(context));
          }
          if (state is ItemErrorState) {
            _showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              if (state is ItemWithDataState) {
                final items = state.items;

                return CustomScrollView(
                  slivers: [
                    _buildHeader(context, state),
                    _buildBody(items),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<ItemBloc>()..add(AddItemEvent()),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: AppDimens.generalPadding),
          FloatingActionButton(
            onPressed: () => context.read<ItemBloc>()..add(RemoveItemEvant()),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(List<ItemModel> items) => SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: AppDimens.maxCrossAxisExtent,
            mainAxisSpacing: AppDimens.mainAxisSpacing,
            crossAxisSpacing: AppDimens.crossAxisSpacing,
            childAspectRatio: AppDimens.childAspectRatio,
            mainAxisExtent: AppDimens.mainAxisExtent),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return items[index];
          },
          childCount: items.length,
        ),
      );

  Widget _buildHeader(BuildContext context, ItemWithDataState state) =>
      SliverList(
        delegate: SliverChildListDelegate(
          [
            AnimatedContainer(
              constraints:
                  const BoxConstraints(minHeight: AppDimens.minLogoHeight),
              duration: AppDimens.changeLogoSiziDuration,
              height: MediaQuery.of(context).size.height * state.expandedHeight,
              color: Colors.green[100],
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.generalPadding),
                child: Center(
                    child: Image.asset(
                  'lib/assets/logo.png',
                )),
              ),
            ),
          ],
        ),
      );

  Future<void> _showErrorSnackBar(String message) async => await Flushbar(
        backgroundGradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.red[100]!,
            Colors.red,
          ],
        ),
        flushbarPosition: FlushbarPosition.TOP,
        title: 'ERROR',
        titleSize: 30,
        message: message,
        messageColor: Colors.white,
        messageSize: 20,
        duration: AppDimens.errorSnackBarDuration,
      ).show(context);
}
