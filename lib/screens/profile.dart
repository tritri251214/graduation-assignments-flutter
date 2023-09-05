// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/common.dart';
import 'package:graduation_assignments_flutter/utils/screen_size.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';
import 'package:graduation_assignments_flutter/widgets/null_text.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _switchCopyEvent = true;
  bool _isEditName = false;
  late TextEditingController _controller;
  final AppStorage storage = Get.put(AppStorage());
  late Size screenSize = getScreenSize(context);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: storage.profileName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSubmitTextName(String text) {
    storage.setProfileName(text);
    setState(() {
      _isEditName = false;
    });
  }

  void _onLogout() {
    storage.clearAll();
    setState(() {
      _controller.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 110,
                      height: 110,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://fastly.picsum.photos/id/660/2508/1672.jpg?hmac=D_MkrRyzUZRYLOGoa4HJ1WJTfnzN0qshbCEPpaCoSuI'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isEditName
                        ? SizedBox(
                            width: 180,
                            child: TextField(
                              controller: _controller,
                              onSubmitted: _onSubmitTextName,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () =>
                                      _onSubmitTextName(_controller.text),
                                  icon:
                                      const Icon(CupertinoIcons.square_arrow_right, size: 16),
                                ),
                                hintText: 'Input name',
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NullText(
                                  text: _controller.text,
                                  style: const TextStyle(
                                      fontFamily: AppStrings.rootFont,
                                      fontSize: 18)),
                              const SizedBox(width: 5),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isEditName = true;
                                    });
                                  },
                                  icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle,
                                      size: 16)),
                            ],
                          ),
                    const SizedBox(height: 5),
                    const Text('infor@tma.com.vn'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text('Settings',
                    style:
                        TextStyle(fontFamily: AppStrings.rootFont, fontSize: 18)),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                color: AppColors.backgroundInput,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Primary City'),
                    Text('Viet Nam'),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                color: AppColors.backgroundInput,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Copy Event to calendar'),
                    Switch.adaptive(
                      value: _switchCopyEvent,
                      applyCupertinoTheme: true,
                      onChanged: (bool value) {
                        setState(() {
                          _switchCopyEvent = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                color: AppColors.backgroundInput,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Manage Events'),
                    Icon(CupertinoIcons.chevron_right),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                color: AppColors.backgroundInput,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Manage Log in options'),
                    Icon(CupertinoIcons.chevron_right),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                color: AppColors.backgroundInput,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Account Settings'),
                    Icon(CupertinoIcons.chevron_right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          width: double.infinity,
          height: screenSize.height * 0.2,
          decoration: const BoxDecoration(
            color: AppColors.backgroundCard,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    color: AppColors.white,
                    child: SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: OutlinedButton(
                        onPressed: _onLogout,
                        style: ButtonStyle(
                          shape:
                              MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: AppDimensions.borderButtonRadius,
                          )),
                          textStyle: const MaterialStatePropertyAll(
                            TextStyle(
                                fontFamily: AppStrings.rootFont,
                                color: AppColors.placeholderText,
                                fontSize: 16),
                          ),
                        ),
                        child: const Text('Logout', style: TextStyle(color: AppColors.primaryColor)),
                      ),
                    ),
                  ),
                ),
                const BottomNavigationBarWidget(selectedMenu: Menu.profile),
              ],
            ),
          )),
    );
  }
}
