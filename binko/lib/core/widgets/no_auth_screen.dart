// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lottie/lottie.dart';

// import '../../generated/locale_keys.g.dart';
// import '../../router/go_route.dart';
// import '../constants/assets.dart';
// import '../extensions/context_extensions.dart';
// import 'main_button.dart';

// class NoAuthScreen extends StatefulWidget {
//   const NoAuthScreen({super.key});

//   @override
//   State<NoAuthScreen> createState() => _NoAuthScreenState();
// }

// class _NoAuthScreenState extends State<NoAuthScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               LottieBuilder.asset(
//                 Assets.assetsAnimationsNeedLogin,
//                 repeat: false,
//                 width: .7.sw,
//               ),
//               // 20.verticalSpace,
//               Text(
//                 LocaleKeys.noAuthScreen_noAuth.tr(),
//                 maxLines: 3,
//                 textAlign: TextAlign.center,
//                 style: context.textTheme.titleMedium
//                     ?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               20.verticalSpace,
//               MainButton(
//                   eleavation: 0,
//                   fontWeight: FontWeight.bold,
//                   width: .5.sw,
//                   text: LocaleKeys.noAuthScreen_login.tr(),
//                   onPressed: () {
//                     context.pushNamed(RouteConfigs.loginScreen);
//                   })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
