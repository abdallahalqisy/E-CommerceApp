part of 'layout_cubit.dart';

@immutable
sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}

final class GetUserDataFailedState extends LayoutState {
  String message;
  GetUserDataFailedState({required this.message});
}

final class GetUserDataSuccessState extends LayoutState {}

final class GetUserDataLodingState extends LayoutState {}

final class ChangeBottomNavigationCurrentIndexState extends LayoutState {}

final class GetBannersDataFailedState extends LayoutState {
  // String message;
  // GetBannersDataFailedState({required this.message});
}

final class GetBannersDataSuccessState extends LayoutState {}

final class GetBannersLodingState extends LayoutState {}

final class GetCategoriesSuccessState extends LayoutState {}

final class FailedToGetCategoriesState extends LayoutState {}

final class GetProductsDataSuccessState extends LayoutState {}

final class GetProductsDataFailedState extends LayoutState {}

final class FilterProudectSuccessState extends LayoutState {}

final class GetFavoritesSuccessState extends LayoutState {}

final class GetFavoritesFailedState extends LayoutState {}

final class AddOrRemoveItemFromFavoritesSuccessState extends LayoutState {}

final class FaildTOAddOrRemoveItemFromFavoritesState extends LayoutState {}

final class GetCartsFailedState extends LayoutState {}

final class GetCartsSuccessState extends LayoutState {}

final class AddCartsSuccessState extends LayoutState {}

final class FaildAddCartsSuccessState extends LayoutState {}

final class UpdateUserDataLoading extends LayoutState {}

final class UpdateUserDataSuccess extends LayoutState {}

final class UpdateUserDatafailyer extends LayoutState {
  String message;
  UpdateUserDatafailyer({required this.message});
}

final class ChangePasswordSuccess extends LayoutState {}

final class ChangePasswordLoding extends LayoutState {}

final class ChangePasswordFaild extends LayoutState {
  String message;
  ChangePasswordFaild({required this.message});
}

final class LogoutSuccessState extends LayoutState {}
