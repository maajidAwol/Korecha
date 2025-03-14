import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/screen_export.dart';
import '../../../domain/entities/category.dart';
import '../../state/category/bloc/category_bloc.dart';

class ExpansionCategory extends StatelessWidget {
  const ExpansionCategory({
    super.key,
    required this.category,
    required this.svgSrc,
  });

  final Category category;
  final String svgSrc;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Theme.of(context).textTheme.bodyLarge!.color,
      collapsedIconColor: Theme.of(context).textTheme.bodyMedium!.color,
      leading: SvgPicture.asset(
        svgSrc,
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color!,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        category.name,
        style: const TextStyle(fontSize: 14),
      ),
      textColor: Theme.of(context).textTheme.bodyLarge!.color,
      childrenPadding: const EdgeInsets.only(left: defaultPadding * 3.5),
      children: List.generate(
        category.subCategories.length,
        (index) => Column(
          children: [
            ListTile(
              onTap: () {
                context.read<CategoryBloc>().add(
                      LoadProductsByCategory(category.subCategories[index].id),
                    );
                Navigator.pushNamed(
                  context,
                  onSaleScreenRoute,
                  arguments: {
                    'category': category.subCategories[index],
                    'title': category.subCategories[index].name,
                  },
                );
              },
              title: Text(
                category.subCategories[index].name,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            if (index < category.subCategories.length - 1)
              const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
