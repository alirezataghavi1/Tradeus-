part of 'history_list_bloc.dart';

@immutable
sealed class HistoryListEvent {}


class HistoryListStarted  extends HistoryListEvent{

}
class HistoryListSearch  extends HistoryListEvent{
  final String searchTerm;

  HistoryListSearch(this.searchTerm);
}
class HistoryListDeleteAll  extends HistoryListEvent{
 
}



class HistoryListSort  extends HistoryListEvent{
 
}