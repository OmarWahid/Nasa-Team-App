import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import '../model/posts_model.dart';
import '../shared/component.dart';
import '../style/iCONS.dart';
import 'FadeAnimation.dart';
import 'comment_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<NasaCubit, NasaState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NasaCubit.get(context);
          if (cubit.isDoneUser ||
              cubit.isDoneNasa ||
              cubit.isDoneSecond ||
              cubit.isDonePosts) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadingGetPosts) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: 8.h,
                bottom: 10.h,
                left: 10.w,
                right: 10.w,
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      context, NasaCubit.get(context).posts[index], index),
                  separatorBuilder: (context, index) => SizedBox(height: 11.h),
                  itemCount: NasaCubit.get(context).posts.length),
            ),
          );
        },
      );
    });
  }

  Widget buildPostItem(context, PostModel model, index) {
    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //profile photo
                InkWell(
                  onTap: () {
                    DisplayPlayPhoto(url: model.image!, context: context);
                  },
                  child: CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: model.image!,
                        fit: BoxFit.cover,
                        width: 44.w,
                        height: 39.h,
                        placeholder: (context, url) {
                          return Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.deepPurple,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 13.w,
                ),
                //name , check mark & date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name & check mark
                      Row(
                        children: [
                          Text(model.name!,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.w,
                          )
                        ],
                      ),
                      Text(
                        model.time!,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(height: 1.2),
                      ),
                    ],
                  ),
                ),
                //three dots
                Padding(
                  padding: EdgeInsets.only(
                    right: 12.w,
                  ),
                  child: Icon(
                    Icons.more_horiz,
                    size: 18.w,
                  ),
                ),
              ],
            ),
            //separator
            Padding(
              padding: EdgeInsets.symmetric(vertical: 11.h),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.text!,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                height: 1.1.h,
                fontSize: 15.sp,
              ),
            ),
            if (model.imagePost != '')
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Container(
                  height: 180.h,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedNetworkImage(
                        imageUrl: model.imagePost!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.deepPurple,
                            ),
                          );
                        },
                      )),
                ),
              ),
            //likes and comments
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 3.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 17.w,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(NasaCubit.get(context).postsId[index])
                                  .collection('likes')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data!.docs.length + 11}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(height: 1.6),
                                  );
                                } else {
                                  return const Text('7');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(NasaCubit.get(context).postsId[index])
                                  .collection('comments')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data!.docs.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(height: 1.6),
                                  );
                                } else {
                                  return const Text('7');
                                }
                              },
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Icon(
                              IconBroken.Chat,
                              size: 17.w,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        NasaCubit.get(context).getIdPostsTest(
                            NasaCubit.get(context).postsId[index]);
                        Navigator.push(
                            context,
                            BouncyPage(
                                widget: CommentsScreen(
                                  indexComments: index,
                                ),
                                curve: Curves.easeOutBack));
                      },
                    ),
                  ),
                ],
              ),
            ),
            //separator
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            //comment like share
            Row(
              children: [
                //write a comment
                Expanded(
                  child: InkWell(
                    onTap: () {
                      NasaCubit.get(context).getIdPostsTest(
                          NasaCubit.get(context).postsId[index]);
                      Navigator.push(
                          context,
                          BouncyPage(
                              widget: CommentsScreen(
                                indexComments: index,
                              ),
                              curve: Curves.easeOutBack));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: NasaCubit.get(context).userData!.image!,
                              fit: BoxFit.cover,
                              height: 30.h,
                              width: 32.w,
                              placeholder: (context, url) {
                                return Center(
                                  child: CupertinoActivityIndicator(
                                    color: Colors.deepPurple,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 13.w,
                        ),
                        Text(
                          'write a comment',
                          style:
                              Theme.of(context).textTheme.caption?.copyWith(),
                        ),
                      ],
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(NasaCubit.get(context).postsId[index])
                      .collection('likes')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      bool isLikeMany = false;
                      snapshot.data!.docs.forEach((element) {
                        if (element.id ==
                            NasaCubit.get(context).userData!.uId) {
                          isLikeMany = true;
                        }
                      });
                      return InkWell(
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 16.w,
                              color: (isLikeMany) ? Colors.red : Colors.grey,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Like',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                    color:
                                        (isLikeMany) ? Colors.red : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ],
                        ),
                        onTap: () {
                          NasaCubit.get(context)
                              .likePost(NasaCubit.get(context).postsId[index]);
                        },
                      );
                    } else {
                      return const Text('7');
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
