import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/post_model.dart';
import '../../../services/post_service.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial()){
    getUsers();
  }
  List<PostModel>posts=[];
  getUsers() async {
    try{
      emit(LayoutGetPostsLoading());
      print("LayoutGetPostsLoading");
      posts = await PostService().getPost();
      print("LayoutGetPostsSuccess");
      emit(LayoutGetPostsSuccess());
    }
    catch(error){
      emit(LayoutGetPostsError(error.toString()));
    }

  }

}
