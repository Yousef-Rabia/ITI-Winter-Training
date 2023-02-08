part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}
class LayoutGetPostsSuccess extends LayoutState {}
class LayoutGetPostsError extends LayoutState {
  String errorMessage;
  LayoutGetPostsError(this.errorMessage);
}
class LayoutGetPostsLoading extends LayoutState {}
