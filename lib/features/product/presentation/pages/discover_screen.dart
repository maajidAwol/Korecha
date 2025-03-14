import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/category/bloc/category_bloc.dart';
import '../widgets/discover/expansion_category.dart';
import '../../../../core/constants/assets.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategories());
  }

  final Map<String, String> categoryIcons = {
    'Clothing': AppAssets.tshirtIcon,
    'Shoes': AppAssets.shoesIcon,
    'Accessories': AppAssets.accessoriesIcon,
    'Electronics': AppAssets.electronicsIcon,
    'Home': AppAssets.homeIcon,
    'Beauty': AppAssets.beautyIcon,
    'Sports': AppAssets.sportsIcon,
    'Books': AppAssets.booksIcon,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is CategoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CategoryBloc>().add(LoadCategories());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CategoriesLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return ExpansionCategory(
                  category: category,
                  svgSrc: categoryIcons[category.name] ?? AppAssets.defaultCategoryIcon,
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
} 