import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/core/widgets/main_button.dart';
import 'package:binko/core/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/services/dependecies.dart';
import '../bloc/book_bloc.dart';

class AddChapterPage extends StatefulWidget {
  final int bookId;

  const AddChapterPage({super.key, required this.bookId});

  @override
  State<AddChapterPage> createState() => _AddChapterPageState();
}

class _AddChapterPageState extends State<AddChapterPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: Text('Add Chapter'),
        centerTitle: true,
        backgroundColor: context.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              .1.sh.verticalSpace,
              FractionallySizedBox(
                widthFactor: .7,
                child: LottieBuilder.asset(
                  Assets.assetsLottieFilesHorror,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(height: 20.h),
              MainTextField(
                controller: _titleController,
                hint: "name of chapter",
                label: 'Title',
              ),
              SizedBox(height: 20.h),
              MainTextField(
                controller: _contentController,
                hint: "content of chapter",
                label: 'Content',
                maxLines: 6,
              ),
              SizedBox(height: 40.h),
              BlocConsumer<BookBloc, BookState>(
                bloc: getIt<BookBloc>(),
                listener: (context, state) {
                  if (state.addChapterStatus == RequestStatus.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Chapter added successfully!')));
                    Navigator.pop(context);
                  } else if (state.addChapterStatus == RequestStatus.failed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add chapter')));
                  }
                },
                builder: (context, state) {
                  if (state.addChapterStatus == RequestStatus.loading) {
                    return CircularProgressIndicator();
                  }
                  return MainButton(
                    width: MediaQuery.of(context).size.width*0.7,
                    text: 'Add Chapter',
                    onPressed: () {
                      getIt<BookBloc>().add(AddChapterEvent(
                        bookId: widget.bookId,
                        title: _titleController.text,
                        content: _contentController.text,
                      ));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
