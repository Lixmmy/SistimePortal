import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'changepassword_event.dart';
part 'changepassword_state.dart';

class ChangepasswordBloc extends Bloc<ChangepasswordEvent, ChangepasswordState> {
  ChangepasswordBloc() : super(ChangepasswordInitial()) {
    on<ChangepasswordEvent>((event, emit) {
    });
  }
}
