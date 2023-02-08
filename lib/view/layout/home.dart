import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iti/view/layout/cubit/layout_cubit.dart';
import 'package:iti/view/layout/post_details.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return BlocProvider(
  create: (BuildContext context) =>LayoutCubit(),
  child:BlocConsumer<LayoutCubit,LayoutState>(
    listener: (BuildContext context, state) {
      if (state is LayoutGetPostsError) {
        final snackbar = SnackBar(
          content: Text(state.errorMessage),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
  },
    builder: (BuildContext context, Object? state) {
      return state is LayoutGetPostsLoading? Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: context.read<LayoutCubit>().posts.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => PostDetails(
              //         post: context.read<LayoutCubit>().posts[index],
              //       )),
              // );
            },
            child: Container(
              color: index%2==0? Colors.white:Colors.red.shade100,
              child: ListTile(
                leading: Text(context.read<LayoutCubit>().posts[index].id.toString()),
                title: Text(context.read<LayoutCubit>().posts[index].title.toString()),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.red,),
              ),
            ),
          );
        },
      );

    },
  ) ,);

  }
}


