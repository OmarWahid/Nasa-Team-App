import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

import '../../style/iCONS.dart';

class HEADS_screen extends StatelessWidget {
  const HEADS_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar = AppBar(
          centerTitle: true,
          elevation: 0,
          toolbarHeight: ScreenUtil().setHeight(48),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45.r),
                bottomRight: Radius.circular(45.r),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepPurple, Colors.deepPurple],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: const Text('High Board',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white)),
          leading: Padding(
            padding: EdgeInsets.only(
              left: 21.w,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_sharp, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: 21.w,
              ),
              child: IconButton(
                icon: const Icon(IconBroken.Search, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        );
        var cubit = NasaCubit.get(context);
        if (cubit.isDoneUser || cubit.isDoneNasa || cubit.isDoneSecond) {
          return Scaffold(
            appBar: appbar,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          appBar: appbar,
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildItem(
                      NasaCubit.get(context).allData[index], context);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 13,
                  );
                },
                itemCount: 6),
          ),
        );
      },
    );
  }

  Widget _buildItem(data, context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.deepPurple,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              top: 10.h,
              bottom: 10.h,
            ),
            // child: Container(
            //   height: 109.h,
            //   width: 116.w,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(18),
            //     image: DecorationImage(
            //       image: NetworkImage( data['image']),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            child: Container(
              height: 109.h,
              width: 116.w,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: Image.network(data['image'], fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CupertinoActivityIndicator(
                      color: Colors.white,
                      radius: 12.r,
                    ));
                  }, errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/Making art-cuate.png',
                      fit: BoxFit.cover,
                    );
                  })),
            ),
          ),
          SizedBox(
            width: 9.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['name'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  data['info'],
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 11.w,
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 25.w,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
