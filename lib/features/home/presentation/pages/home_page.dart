import 'package:bloc_hive_caching_data/core/dependency_injection/di.dart';
import 'package:bloc_hive_caching_data/core/dependency_injection/di_ex.dart';
import 'package:bloc_hive_caching_data/core/pages/error_page.dart';
import 'package:bloc_hive_caching_data/core/utils/custom_alert.dart';
import 'package:bloc_hive_caching_data/core/utils/custom_loading_widget.dart';
import 'package:bloc_hive_caching_data/features/home/data/models/product_model.dart';
import 'package:bloc_hive_caching_data/features/home/presentation/bloc/home_status/products_status.dart';
import 'package:bloc_hive_caching_data/features/home/presentation/widgets/bnb.dart';
import 'package:bloc_hive_caching_data/features/home/presentation/widgets/home_single_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('Caching Data with BLOC & HIVE'),
            Text(
              '@ProgramingWithSoulivanh',
              style: theme.textTheme.labelMedium!.copyWith(color: Colors.grey),
            ),
          ],
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BNB(),
      body: SizedBox(
        width: width,
        height: height,
        child: BlocConsumer<HomeBloc, HomeState>(
          ///build when
          buildWhen: (previous, current) {
            return previous.homeProductsStatus != current.homeProductsStatus;
          },

          ///listen when
          listenWhen: (previous, current) {
            return previous.homeProductsStatus != current.homeProductsStatus;
          },

          ///builder
          builder: (BuildContext context, HomeState state) {
            ///init state status
            if (state.homeProductsStatus is HomeProductsStatusInit) {
              return Center();
            }

            ///Loading state status
            if (state.homeProductsStatus is HomeProductsStatusLoading) {
              return CustomLoading.showWithStyle(context);
            }

            /// error state status
            if (state.homeProductsStatus is HomeProductsStatusError) {
              final HomeProductsStatusError emProducts =
                  state.homeProductsStatus as HomeProductsStatusError;
              final String errorMsg = emProducts.errorMsg;
              return CommonErrorPage(
                isForNetwork: true,
                description: errorMsg,
                onRetry: () {
                  BlocProvider.of<HomeBloc>(
                    context,
                  ).add(const HomeCallProductsEvent());
                },
              );
              // return Center(child: Text(errorMsg));
            }
            // complete state status
            if (state.homeProductsStatus is HomeProductsStatusCompleted) {
              final HomeProductsStatusCompleted cmProducts =
                  state.homeProductsStatus as HomeProductsStatusCompleted;
              final ProductsModel productsModel = cmProducts.products;

              return LiquidPullToRefresh(
                backgroundColor: theme.scaffoldBackgroundColor,
                color: theme.primaryColor,
                showChildOpacityTransition: true,
                onRefresh: () async {
                  BlocProvider.of<HomeBloc>(
                    context,
                  ).add(const HomeCallProductsEvent());
                },
                child: ListView.builder(
                  itemCount: productsModel.products.length,
                  itemBuilder: (context, index) {
                    final Product current = productsModel.products[index];

                    return HomeSingeListItem(current: current);
                  },
                ),
              );
              // return Center(child: Text(productsModel.products[0].category));
              // return Center(child: Text(productsModel.message.toString()));
            }

            return SizedBox.shrink();
          },
          listener: (BuildContext context, HomeState state) async {
            /// Home Completed State
            if (state.homeProductsStatus is HomeProductsStatusCompleted) {
              final HomeProductsStatusCompleted cmProduct =
                  state.homeProductsStatus as HomeProductsStatusCompleted;
              final ProductsModel products = cmProduct.products;
              final bool isFromNetwork = await di<InternetConnectionHelper>()
                  .checkInternetConnection();

              final String msg = isFromNetwork
                  ? " From Server 🌐"
                  : " From Local Source 📄";
              context.mounted
                  ? CustomAlert.show(context, products.message + msg)
                  : null;
            }
          },
        ),
      ),
    );
  }
}
