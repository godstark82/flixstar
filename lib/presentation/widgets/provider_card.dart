// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dooflix/data/models/movie_provider_model.dart';
// import 'package:dooflix/presentation/pages/network_page.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MovieProviderCard extends StatelessWidget {
//   final MovieProvider provider;
//   final VoidCallback onTap;
//   const MovieProviderCard(
//       {super.key, required this.provider, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.to(()=> NetworkItemsPage(network: provider));
//       },
//       radius: 15,
//       child: Container(
//         height: 50,
//         width: 200,
//         margin: EdgeInsets.all(12),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//             color: Colors.grey.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(16)),
//         child: SizedBox(
//           height: 50,
//           width: 200,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: CachedNetworkImage(imageUrl: provider.logo_path)),
//               SizedBox(width: 10),
//               Text(provider.provider_name, overflow: TextOverflow.ellipsis),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
