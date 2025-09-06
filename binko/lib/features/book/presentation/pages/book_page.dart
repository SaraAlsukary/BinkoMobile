

import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/services/dependecies.dart';

class BookPage extends StatefulWidget {
  const BookPage({
    super.key,
    required this.book,
    this.initialChapterIndex = 0,
  });

  final BooksModel book;
  final int initialChapterIndex;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final ValueNotifier<double> _fontSize = ValueNotifier(18);
  final ValueNotifier<String> _fontFamily = ValueNotifier('Markazi');
  final ValueNotifier<Color> _backgroundColor = ValueNotifier(Colors.white);

  final List<String> _fontFamilies = ['Markazi', 'Roboto', 'Leckerli'];
  final List<Color> _backgroundColors = [
    Colors.white,
    Colors.grey.shade200,
    Color.fromARGB(255, 212, 255, 195),
    Color(0xFFF5E6D3),
    Color(0xFF303030),
  ];

  late final PageController _pageController;
  bool _hasJumpedToInitial = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: widget.initialChapterIndex);

    getIt<BookBloc>().add(GetBookchaptersEvent(id: widget.book.id!));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fontSize.dispose();
    _fontFamily.dispose();
    _backgroundColor.dispose();
    super.dispose();
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('book.settings'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('book.font_size'.tr()),
            ValueListenableBuilder(
              valueListenable: _fontSize,
              builder: (context, fontSize, child) {
                return Slider(
                  value: fontSize,
                  min: 12.0,
                  max: 32.0,
                  divisions: 20,
                  label: fontSize.round().toString(),
                  onChanged: (value) {
                    _fontSize.value = value;
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Text('book.font_family'.tr()),
            ValueListenableBuilder(
              valueListenable: _fontFamily,
              builder: (context, fontFamily, child) {
                return DropdownButton<String>(
                  value: fontFamily,
                  isExpanded: true,
                  items: _fontFamilies.map((String family) {
                    return DropdownMenuItem<String>(
                      value: family,
                      child: Text(family),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      _fontFamily.value = value;
                    }
                  },
                );
              },
            ),
            SizedBox(height: 20),
            Text('book.background'.tr()),
            ValueListenableBuilder(
              valueListenable: _backgroundColor,
              builder: (context, backgroundColor, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _backgroundColors.map((Color color) {
                    return GestureDetector(
                      onTap: () {
                        _backgroundColor.value = color;
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(
                            color: backgroundColor == color
                                ? context.primaryColor
                                : Colors.grey,
                            width: backgroundColor == color ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('dialog.close'.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _backgroundColor,
      builder: (context, backgroundColor, child) {
        return BlocListener<BookBloc, BookState>(
          bloc: getIt<BookBloc>(),
          listener: (context, state) {
            if (state.chapterStatus == RequestStatus.success && !_hasJumpedToInitial) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final target = widget.initialChapterIndex;
                final maxIndex = (state.chapters.length - 1).clamp(0, state.chapters.length - 1);
                final safeIndex = target <= maxIndex ? target : 0;
                try {
                  _pageController.jumpToPage(safeIndex);
                } catch (_) {
                }
                _hasJumpedToInitial = true;
              });
            }
          },
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text(widget.book.name ?? ''),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: _showSettingsDialog,
                ),
              ],
            ),
            body: BlocBuilder<BookBloc, BookState>(
              bloc: getIt<BookBloc>(),
              builder: (context, state) {
                if (state.chapterStatus != RequestStatus.success) {
                  return Center(
                    child: state.chapterStatus == RequestStatus.failed
                        ? IconButton.filled(
                      onPressed: () {
                        getIt<BookBloc>().add(GetBookchaptersEvent(
                          id: widget.book.id!,
                        ));
                      },
                      icon: Icon(Icons.refresh),
                      tooltip: 'book.refresh'.tr(),
                    )
                        : CircularProgressIndicator(),
                  );
                }

                if (state.chapters.isEmpty) {
                  return Center(
                    child: Text('error.no_chapters'.tr()),
                  );
                }

                return ValueListenableBuilder(
                  valueListenable: _fontSize,
                  builder: (context, fontSize, _) {
                    return ValueListenableBuilder(
                      valueListenable: _fontFamily,
                      builder: (context, fontFamily, _) {
                        return PageView.builder(
                          controller: _pageController,
                          itemCount: state.chapters.length,
                          itemBuilder: (context, index) {
                            final chapter = state.chapters[index];
                            return SingleChildScrollView(
                              padding: const EdgeInsets.all(18.0),
                              child: HtmlWidget(
                                chapter.content ?? '',
                                textStyle: TextStyle(
                                  fontSize: fontSize,
                                  fontFamily: fontFamily,
                                  color: backgroundColor == Color(0xFF303030)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
