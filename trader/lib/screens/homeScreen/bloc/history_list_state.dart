part of 'history_list_bloc.dart';

@immutable
sealed class HistoryListState {}

 class HistoryListInitial extends HistoryListState {}

class HistoryListLoading extends HistoryListState{

}
class HistoryListSuccess extends HistoryListState{
  final List<History> items;

  HistoryListSuccess(this.items);
  
}
class HistoryListEmpty extends HistoryListState{
  
}
class HistoryListError extends HistoryListState{
  final String errorMessage;

  HistoryListError(this.errorMessage);
}

