import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/components/skleton/product/products_skelton.dart';
import 'package:shop/features/product/domain/usecases/get_filtered_products.dart';
import 'package:shop/features/product/presentation/state/home/bloc/home_bloc.dart';
import 'package:shop/models/product_model.dart';

import '../../../../../constants.dart';
import '../../../../../route/route_constants.dart';

class BestSellers extends StatelessWidget {
  const BestSellers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Hot Deals",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // const ProductsSkelton(),
        SizedBox(
          height: 220,
          child: BlocBuilder<HomeBloc, HomeState>(
            
            builder: (context, state) {
              if (state is HomeLoading) {
                return const ProductsSkelton();
              } else if (state is HomeLoaded) {
                final products = state.products[ProductFilter.hotDeals] ?? [];
                if (products.isEmpty) {
                  return const Center(child: Text('No products available'));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == state.products.length - 1
                          ? defaultPadding
                          : 0,
                    ),
                    child: ProductCard(
                        image: products[index].coverUrl,
                        brandName: products[index].name,
                      title: products[index].subDescription,
                      price: products[index].priceSale ?? products[index].price,
                      priceAfetDiscount: products[index].price,
                      dicountpercent: products[index].priceSale != null
                          ? ((products[index].price -
                                  products[index].priceSale!) /
                              products[index].price *
                              100)
                              .round()
                          : 0,
                      press: () {

                        Navigator.pushNamed(
                          context,
                          productDetailsScreenRoute,
                          arguments: {
                            'isProductAvailable': true,
                            'productId': products[index].id,
                          },
                          
                        );
                      },
                    ),
                  ),
                );
              } else if (state is HomeError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
