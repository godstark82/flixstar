import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dooflix/data/models/network_model.dart';
import 'package:dooflix/presentation/pages/network_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkCard extends StatelessWidget {
  final NetworkModel network;
  const NetworkCard({super.key, required this.network});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
    
        Get.to(()=> NetworkItemsPage(network: network));
      },
      child: UnconstrainedBox(
        child: Container(
          height: 60,
          width: 120,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(network.logoPath))),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  // color: Colors.black45,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
