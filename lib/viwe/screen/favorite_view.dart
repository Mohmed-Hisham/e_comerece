import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_comerece/controller/favorite/favorite_view_controller.dart';
import 'package:e_comerece/core/class/statusrequest.dart';
import 'package:e_comerece/data/model/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteViewController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        titleTextStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: GetBuilder<FavoriteViewController>(
        builder: (controller) {
          if (controller.statusrequest == Statusrequest.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.statusrequest == Statusrequest.failuer) {
            return const Center(child: Text('Failed to load favorites'));
          } else if (controller.favorites.isEmpty) {
            return const Center(child: Text('No favorite items yet!'));
          } else {
            return ListView.builder(
              itemCount: controller.favoritesByPlatform.keys.length,
              itemBuilder: (context, index) {
                String platform = controller.favoritesByPlatform.keys.elementAt(
                  index,
                );
                List<FavoriteModel> favorites =
                    controller.favoritesByPlatform[platform]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        platform,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount: favorites.length,
                      itemBuilder: (context, gridIndex) {
                        FavoriteModel favorite = favorites[gridIndex];
                        return ProductCard(
                          favorite: favorite,
                          onDelete: () =>
                              controller.removeFavorite(favorite.productId!),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final FavoriteModel favorite;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.favorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: 'https:${favorite.productImage}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite.productTitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${favorite.productPrice}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
