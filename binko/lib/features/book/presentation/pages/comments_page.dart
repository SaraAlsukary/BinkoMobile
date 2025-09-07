// lib/features/book/presentation/pages/comments_page.dart
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:binko/core/services/dependecies.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:binko/features/book/presentation/pages/replies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class CommentsPage extends StatefulWidget {
  final BooksModel book;

  const CommentsPage({super.key, required this.book});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final BookBloc _bloc = getIt<BookBloc>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.book.id != null) {
      _bloc.add(GetCommentsEvent(bookId: widget.book.id!));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    if (widget.book.id != null) {
      _bloc.add(GetCommentsEvent(bookId: widget.book.id!));
    }
    await Future.delayed(const Duration(milliseconds: 300));
  }

  void _openReplySheet(BuildContext context, int commentId) {
    final TextEditingController controller = TextEditingController();
    final user = getIt<AuthBloc>().state.user;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Write a reply", style: context.textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Write your reply...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        final text = controller.text.trim();
                        if (text.isEmpty) return;
                        if (user == null) {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Login required to reply')),
                          );
                          return;
                        }

                        // send AddReplyEvent via BookBloc
                        getIt<BookBloc>().add(AddReplyEvent(
                          userId: user.id!,
                          commentId: commentId,
                          content: text,
                        ));

                        Navigator.pop(ctx);

                        // refresh comments to update reply_count
                        if (widget.book.id != null) {
                          _bloc.add(GetCommentsEvent(bookId: widget.book.id!));
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reply added ✅')),
                        );
                      },
                      child: const Text('Send',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade600,
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Comments',
          style: context.textTheme.titleLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.commentsStatus == RequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.commentsStatus == RequestStatus.failed) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 60),
                  Center(child: Text('failed to load comments')),
                ],
              ),
            );
          }

          final comments = state.comments;
          if (comments.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 60),
                  Center(child: Text('no comments yet')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              itemCount: comments.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                final c = comments[index];
                final replyCount = c.replyCount ?? 0;
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.comment ?? '',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (c.id != null) _openReplySheet(context, c.id!);
                            },
                            icon: const Icon(Icons.reply, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          // show replies count and more button
                          if (replyCount > 0) ...[
                            Text(
                              '$replyCount replies',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: () {
                                if (c.id != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RepliesPage(
                                          commentId: c.id!,
                                          commentText: c.comment ?? ''),
                                    ),
                                  );
                                }
                              },
                              child: const Text('More',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
