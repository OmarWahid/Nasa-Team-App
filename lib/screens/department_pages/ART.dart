import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_app/all_cubit/shop_cubit/cubit_shop.dart';
import 'package:nasa_app/all_cubit/shop_cubit/states_shop.dart';

class ART_screen extends StatelessWidget {
  const ART_screen({Key? key}) : super(key: key);

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
          title: const Text('Art Committee',
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white)),
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
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            title: const Text('Art Committee',
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.white)),
          ),
          body: Center(
            child: Text('Art'),
          ),
        );
      },
    );
  }
}
