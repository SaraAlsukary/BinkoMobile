// lib/features/book/presentation/pages/replies_page.dart
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:binko/core/services/dependecies.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/core/widgets/main_button.dart';
import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class RepliesPage extends StatefulWidget {
  final int commentId;
  final String commentText;

  const RepliesPage(
      {super.key, required this.commentId, this.commentText = ''});

  @override
  State<RepliesPage> createState() => _RepliesPageState();
}

class _RepliesPageState extends State<RepliesPage> {
  final BookBloc _bloc = getIt<BookBloc>();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetRepliesEvent(commentId: widget.commentId));
  }

  void _sendReply() {
    final text = _controller.text.trim();
    final user = getIt<AuthBloc>().state.user;
    if (text.isEmpty) return;

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login required')));
      return;
    }

    _bloc.add(AddReplyEvent(
      userId: user.id!,
      commentId: widget.commentId,
      content: text,
    ));

    _controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        backgroundColor: context.primaryColor,
        centerTitle: true,
        title: Text(
          'Replies',
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          if (widget.commentText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(widget.commentText,
                  style: context.textTheme.titleMedium),
            ),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state.repliesStatus == RequestStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.repliesStatus == RequestStatus.failed) {
                  return Center(
                    child: TextButton(
                      onPressed: () => _bloc
                          .add(GetRepliesEvent(commentId: widget.commentId)),
                      child: const Text('Retry'),
                    ),
                  );
                } else if (state.replies.isEmpty) {
                  return const Center(child: Text('No replies yet'));
                }

                final replies = state.replies.where((r) {
                  if (r.commentId == null)
                    return true;
                  return r.commentId.toString() == widget.commentId.toString();
                }).toList();

                if (replies.isEmpty) {
                  return const Center(child: Text('No replies yet'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: replies.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    final r = replies[i];
                    return ListTile(
                      leading: r.userImage != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(r.userImage!))
                          : const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(r.userName ?? 'User'),
                      subtitle: Text(r.content ?? ''),
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Write a reply...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  MainButton(
                    text: 'Send',
                    onPressed: _sendReply,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
