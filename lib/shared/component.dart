
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

String ? uId ='';
var nasa ;
var height ;
var width ;



Future<void> DisplayPlayPhoto ({required String url,context}) async {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.all(0.0),
        backgroundColor: Colors.transparent,
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context)
                .size
                .height;
            var width =
                MediaQuery.of(context).size.width;

            return Container(
              padding: EdgeInsets.zero,
              height: height - 350,
              width: width,
              child: InteractiveViewer(
                minScale: 1,
                maxScale: 2,

                child: CachedNetworkImage(
                  imageUrl:  url,
                ),
              ),
            );
          },
        ),
      )
  );
}
