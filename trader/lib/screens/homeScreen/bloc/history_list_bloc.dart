import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trader/data/data.dart';
import 'package:trader/data/repo/repository.dart';

part 'history_list_event.dart';
part 'history_list_state.dart';

class HistoryListBloc extends Bloc<HistoryListEvent, HistoryListState> {
  final Repository<History> repository;
  HistoryListBloc(this.repository) : super(HistoryListInitial()) {
    on<HistoryListEvent>((event, emit) async {
    if(event is HistoryListSearch || event is HistoryListStarted ){
 final String searchTerm;
      emit(HistoryListLoading());
      
      if (event is HistoryListSearch) {
        searchTerm = event.searchTerm.toUpperCase();
      } else {
        searchTerm = '';
      }

      try {
        final items = await repository.getAll(searchKeyword: searchTerm);
        if (items.isNotEmpty) {
          emit(HistoryListSuccess(items));
        } else {
          emit(HistoryListEmpty());
        }
      } catch (e) {
        emit(HistoryListError('Unknown Error'));
      }
    }else if(event is HistoryListDeleteAll){
        await repository.deleteAll();
        emit(HistoryListEmpty());
    
    
    }
    });
  }
}
