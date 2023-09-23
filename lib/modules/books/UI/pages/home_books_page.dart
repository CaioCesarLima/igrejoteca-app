import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_app/core/theme/colors.dart';
import 'package:igrejoteca_app/core/utils/consts.dart';
import 'package:igrejoteca_app/modules/books/UI/pages/widgets/card_book_widget.dart';
import 'package:igrejoteca_app/modules/books/data/models/book_model.dart';
import 'package:igrejoteca_app/modules/books/store/bloc/book/bloc/book_bloc.dart';
import 'package:igrejoteca_app/modules/books/store/bloc/book/event/book_event.dart';
import 'package:igrejoteca_app/modules/books/store/bloc/book/state/book_state.dart';
import 'package:igrejoteca_app/shared/Widgets/custom_drawer.dart';

class HomeBooksPage extends StatefulWidget {
  const HomeBooksPage({super.key});

  static const String route = '/books';

  @override
  State<HomeBooksPage> createState() => _HomeBooksPageState();
}

class _HomeBooksPageState extends State<HomeBooksPage> {
  late BookBloc _bookbloc;

  @override
  void initState() {
    super.initState();
    _bookbloc = GetIt.I<BookBloc>();
    _bookbloc.add(GetBook(token: "token"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookBloc, BookState>(
      listener: (context, state) {
        if(state is ReservedBookState){
        }
        if(state is ErrorReservedBookState){
          _bookbloc.add(GetBook(token: ""));
        }
      },
      bloc: _bookbloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightBlueColor,
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Livros"),
          ),
          drawer: const CustomDrawer(),
          body: Column(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Consts.khorintalPading),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Pesquisar",
                                  suffixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              (state is LoadedBookState)
                  ? BodyHomeBook(list: state.books,)
                  : const Expanded(
                    child: Center(
                    child: CircularProgressIndicator(),
                      ),
                  ),
            ],
          ),
        );
      },
    );
  }
}

class BodyHomeBook extends StatelessWidget {
  final List<BookModel> list;
  const BodyHomeBook({
    Key? key, required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: list.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
          return CardBookWidget(book: list[index]);
      },
    ),
        ));
  }
}
