import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:trader/data/data.dart';
import 'package:trader/data/repo/repository.dart';
import 'package:trader/gen/assets.gen.dart';
import 'package:trader/provider/provider.dart';

import 'package:trader/screens/homeScreen/bloc/history_list_bloc.dart';
import 'package:trader/screens/information/information.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final themeData = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return InformationScreen(
              history: History(),
            );
          }));
        },
        child: const Icon(CupertinoIcons.add),
      ),
      body: BlocProvider<HistoryListBloc>(
        create: (context) =>
            HistoryListBloc(context.read<Repository<History>>()),
        child: Builder(builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(CupertinoIcons.left_chevron),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Text(
                      localization.slogan1,
                      style: themeData.textTheme.bodyMedium!
                          .copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      localization.slogan2,
                      style:
                          themeData.textTheme.bodyLarge!.copyWith(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.70,
                        decoration: BoxDecoration(
                            color: themeData.colorScheme.onSecondary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          autofocus: false,
                          controller: searchController,
                          onChanged: (value) {
                            context
                                .read<HistoryListBloc>()
                                .add(HistoryListSearch(value));
                          },
                          cursorColor: themeData.colorScheme.onPrimary,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.only(bottom: 18),
                              prefixIcon: const Icon(CupertinoIcons.search),
                              label: Text(localization.searchField,
                                  style: themeData.textTheme.bodySmall)),
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.secondary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onTap: () {
                              final provider = Provider.of<ProviderLoc>(context,
                                  listen: false);
                              if (provider.locale == Locale('en')) {
                                provider.setLocale(Locale('fa'));
                              }else if (provider.locale == Locale('fa'))
                              provider.setLocale(Locale('en'));
                            },
                            child: Icon(
                              Icons.language,
                              color: themeData.colorScheme.secondary,
                            ),
                          )),
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: themeData.colorScheme.secondary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onTap: () {
                              context
                                  .read<HistoryListBloc>()
                                  .add(HistoryListDeleteAll());
                            },
                            child: Icon(
                              CupertinoIcons.delete,
                              color: themeData.colorScheme.secondary,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(child: Consumer<Repository<History>>(
                    builder: (context, model, child) {
                      context.read<HistoryListBloc>().add(HistoryListStarted());
                      return BlocBuilder<HistoryListBloc, HistoryListState>(
                          builder: (context, state) {
                        if (state is HistoryListSuccess) {
                          return HistoryList(
                              boxItem: state.items, themeData: themeData);
                        } else if (state is HistoryListEmpty) {
                          return const Center(
                            child: Text('Your List Is Empty'),
                          );
                        } else if (state is HistoryListLoading ||
                            state is HistoryListInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is HistoryListError) {
                          return Center(
                            child: Text(state.errorMessage),
                          );
                        } else {
                          throw Exception('State is not Valid');
                        }
                      });
                    },
                  )),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class HistoryList extends StatefulWidget {
  const HistoryList({
    super.key,
    required this.boxItem,
    required this.themeData,
  });

  final Iterable<History> boxItem;
  final ThemeData themeData;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70),
      physics: const BouncingScrollPhysics(),
      itemCount: widget.boxItem.length,
      itemBuilder: (BuildContext context, int index) {
        final History history = widget.boxItem.toList()[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: HistoryItem(themeData: widget.themeData, history: history),
        );
      },
    );
  }
}

class HistoryItem extends StatefulWidget {
  const HistoryItem({
    super.key,
    required this.themeData,
    required this.history,
  });

  final ThemeData themeData;
  final History history;

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InformationScreen(history: widget.history)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color:
                    const Color.fromARGB(255, 238, 223, 223).withOpacity(0.05),
                blurRadius: 3,
                spreadRadius: 3)
          ],
          color: widget.themeData.colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Assets.image.homeCard.cardpic
                      .image(width: 80, height: 80),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.history.currencyName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        Text(
                          '${localization.openingPrice}: ${widget.history.openedPrice}',
                          style: widget.themeData.textTheme.bodySmall!
                              .copyWith(color: Colors.green),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${localization.closingPrice}: ${widget.history.closedPrice}',
                          style: widget.themeData.textTheme.bodySmall!
                              .copyWith(color: Colors.red),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${localization.margin}: ${widget.history.margin}',
                          style: widget.themeData.textTheme.bodySmall!.copyWith(
                              color: widget.themeData.colorScheme.onPrimary),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '${localization.leverage}: ${widget.history.leverage}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: widget.themeData.textTheme.bodySmall!
                                .copyWith(
                                    color:
                                        widget.themeData.colorScheme.onPrimary),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.history.openedDate.substring(0, 10),
                    style: widget.themeData.textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        final historyRepository =
                            Provider.of<Repository<History>>(
                          context,
                          listen: false,
                        );
                        historyRepository.delete(widget.history);
                      },
                      child: const Icon(
                        CupertinoIcons.delete_solid,
                        size: 22,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.history.openedDate.substring(10),
                    style: widget.themeData.textTheme.bodySmall,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
