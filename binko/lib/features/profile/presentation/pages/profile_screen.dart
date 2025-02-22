import 'package:binko/core/extensions/context_extensions.dart';
import 'package:binko/core/widgets/main_button.dart';
import 'package:binko/core/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  width: .50.sw,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '+',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                )),
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    TabBar(
                        overlayColor: WidgetStateColor.resolveWith(
                          (states) => context.primaryColor,
                        ),
                        tabs: [
                          Tab(
                            text: 'Settings',
                          ),
                          Tab(
                            text: 'My Favorite',
                          ),
                          Tab(
                            text: 'My Published Books',
                          ),
                        ]),
                    Expanded(
                      child: TabBarView(children: [
                        Container(
                          padding: EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MainTextField(
                                label: 'Bio',
                              ),
                              20.verticalSpace,
                              MainTextField(
                                label: 'User Name',
                              ),
                              20.verticalSpace,
                              MainButton(text: 'Change', onPressed: () {}),
                              10.verticalSpace,
                              Center(
                                child: MainButton(
                                    borderColor: context.primaryColor,
                                    textColor: context.primaryColor,
                                    color: context.scaffoldBackgroundColor,
                                    hasBorder: true,
                                    onPressed: () {},
                                    text: 'Log Out'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(),
                        SizedBox(),
                      ]),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
