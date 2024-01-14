import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF1FA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Positioned(
                //   right: product.id == 2 ? 0 : 20,
                //   bottom: -80,
                //   child: Image.asset(product.image!, height: 260)
                //       .animate()
                //       .slideX(
                //         duration: const Duration(milliseconds: 200),
                //         begin: 1,
                //         curve: Curves.easeInSine,
                //       ),
                // ),
                // Positioned(
                //   left: 15,
                //   bottom: 20,
                //   child: GetBuilder<BaseController>(
                //     id: 'FavoriteButton',
                //     builder: (controller) => GestureDetector(
                //       onTap: () => controller.onFavoriteButtonPressed(
                //           productId: product.id!),
                //       child: CircleAvatar(
                //         radius: 18.,
                //         backgroundColor: Colors.white,
                //         child: SvgPicture.asset(
                //           product.isFavorite!
                //               ? Constants.favFilledIcon
                //               : Constants.favOutlinedIcon,
                //           color:
                //               product.isFavorite! ? null : theme.primaryColor,
                //         ),
                //       ),
                //     ),
                //   ),
                // ).animate().fade(),
              ],
            ),

            // Text(product.name!, style: theme.textTheme.bodyMedium)
            //     .animate()
            //     .fade()
            //     .slideY(
            //       duration: const Duration(milliseconds: 200),
            //       begin: 1,
            //       curve: Curves.easeInSine,
            //     ),
            // Text('\$${product.price}', style: theme.textTheme.displaySmall)
            //     .animate()
            //     .fade()
            //     .slideY(
            //       duration: const Duration(milliseconds: 200),
            //       begin: 2,
            //       curve: Curves.easeInSine,
            //     ),
          ],
        ),
      ),
    );
  }
}
