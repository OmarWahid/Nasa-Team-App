import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';
import 'package:nasa_app/screens/chat_screen.dart';

import '../model/chat_model.dart';
import '../shared/component.dart';

var searchController = TextEditingController();

class SearchScreen extends StatefulWidget {
  final List<ChatModel>? chatListSearch;

  const SearchScreen({required this.chatListSearch, Key? key})
      : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //List<dynamic> listSearch = [];
  dynamic listSearch;
  bool isNotFound = false;
  String? search;

  @override
  void initState() {
    // TODO: implement initState
    //   listSearch = PlantsCubit.get(context).blogsModel!.data!.seeds;
    listSearch = [];
    super.initState();
  }

  void searchFilter(String value) {
    dynamic result;

    if (value.isEmpty) {
      result = [];
    } else {
      result = widget.chatListSearch!
          .where((element) =>
              element.text!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      search = value;
      if(value == ''){
        listSearch = result;
        isNotFound = false;
      }
      else if  (result.isEmpty) {
        listSearch = result;
        isNotFound = true;
      } else {
        listSearch = result;
        isNotFound = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            searchController.clear();
            return true;
          },
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 58.h,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide:  BorderSide(
                              width: 3,
                            color: Colors.grey[100]!,
                          ), //<-- SEE HERE
                        ),
                        filled: true,
                        fillColor:Colors.grey[100]!,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[500]!,
                        ),
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          color: Colors.grey[500]!,
                          size: 25.w,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 0.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                            color: Color(0xFFF8F8F8),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                            color: Color(0xFFF8F8F8),
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) {},
                      onChanged: (value) => searchFilter(value),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    (isNotFound)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Results for “$search”',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '0 found',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.deepPurple,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 38.h,
                              ),
                              Image.asset('assets/images/searching-error.png',
                                  height: 250.h,
                                  width: MediaQuery.of(context).size.width ,
                                  fit: BoxFit.cover),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text('Not found',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff212121),
                                  )),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                  textAlign: TextAlign.center,
                                  'Sorry, the keyword you entered cannot be\nfound, please check again or search with\n another keyword.',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    height: 1.3.h,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  )),
                            ],
                          )
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 22.h),
                            itemBuilder: (context, index) {
                              if (listSearch[index].senderId ==
                                  NasaCubit.get(context).userData!.uId)
                                return buildItemMyMessage(
                                    context, listSearch[index], index);
                              return buildItemMessage(
                                  context, listSearch[index], index);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 22.h,
                              );
                            },
                            itemCount: listSearch.length),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildItemMyMessage(context, ChatModel model, index) {
    String givenStr = model.time!;
    String finalStr = givenStr.substring(14, 18) + givenStr.substring(21);
    return Padding(
      padding: EdgeInsets.only(
        bottom: index == 0 ? 9.h : 0.h,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  finalStr,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 9.5.sp),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text('You',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 9.h,
              ),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.4),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(15.r),
                    bottomStart: Radius.circular(15.r),
                    bottomEnd: Radius.circular(25.r),
                  )),
              // child: Text('${message.text}'),
              child: Text(model.text!,
                  textDirection: (model.text!.contains(RegExp(r'[أ-ي]')))
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  style: TextStyle(height: 1.1.h)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemMessage(context, ChatModel model, index) {
    String givenStr = model.time!;
    String finalStr = givenStr.substring(14, 18) + givenStr.substring(21);
    return Padding(
      padding: EdgeInsets.only(
        bottom: index == 0 ? 9.h : 0.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 5.h,
            ),
            child: InkWell(
              onTap: () {
                DisplayPlayPhoto(url: model.image!, context: context);
              },
              child: CircleAvatar(
                radius: 25.r,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: model.image!,
                    fit: BoxFit.cover,
                    height: 50.h,
                    width: 50.w,
                    placeholder: (context, url) {
                      return const Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.deepPurple,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: (model.name! == 'Omar Wahid')
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(model.name!,
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                      if (model.name! == 'Omar Wahid')
                        SizedBox(
                          width: 3.w,
                        ),
                      if (model.name! == 'Omar Wahid')
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.7.w,
                        ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        finalStr,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 9.5.sp,
                            ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(15.r),
                          bottomStart: Radius.circular(25.r),
                          bottomEnd: Radius.circular(15.r),
                        )),
                    // child: Text('${message.text}'),
                    child: Text(model.text!,
                        textDirection: (model.text!.contains(RegExp(r'[أ-ي]')))
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        style: TextStyle(height: 1.1.h)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
