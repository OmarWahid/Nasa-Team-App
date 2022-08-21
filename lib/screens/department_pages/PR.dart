import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

class PR_screen extends StatelessWidget {
  const PR_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NasaCubit, NasaState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var appbar = AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: const Text('Public Relations',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
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
          appBar:appbar,
          body: Center(
            child: Text('PR'),
          ),
        );
      },
    );
  }
}
