import 'package:flutter/material.dart';
import 'package:graduation_assignments_flutter/common/colors.dart';
import 'package:graduation_assignments_flutter/common/dimensions.dart';
import 'package:graduation_assignments_flutter/utils/utils.dart';
import 'package:graduation_assignments_flutter/widgets/bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _switchCopyEvent = false;
  bool _isEditName = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: 'Minh Tri');
  }

  Future<void> _onSubmitTextName(String text) async {
    setState(() {
      _isEditName = false;
    });
  }

  void _onLogout() {
    showNeedImplement(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  _isEditName ?
                    SizedBox(
                      width: 180,
                      child: TextField(
                        controller: _controller,
                        onSubmitted: _onSubmitTextName,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () =>
                                _onSubmitTextName(_controller.text),
                            icon: const Icon(Icons.send_outlined, size: 16),
                          ),
                          hintText: 'Input name',
                        ),
                      ),
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_controller.text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(width: 5),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _isEditName = true;
                              });
                            },
                            icon: const Icon(Icons.edit_outlined, size: 16)),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                  SizedBox(
                    width: 50,
                    height: 30,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch.adaptive(
                        value: _switchCopyEvent,
                        onChanged: (bool value) {
                          setState(() {
                            _switchCopyEvent = value;
                          });
                        },
                      ),
                    ),
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
                  Icon(Icons.chevron_right_outlined),
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
                  Icon(Icons.chevron_right_outlined),
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
                  Icon(Icons.chevron_right_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                width: double.infinity,
                height: 60.0,
                child: OutlinedButton(
                  onPressed: _onLogout,
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: AppDimensions.borderButtonRadius,
                    )),
                    textStyle: const MaterialStatePropertyAll(
                      TextStyle(
                          color: AppColors.placeholderText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              ),
            ),
            const BottomNavigationBarWidget(selectedMenu: Menu.profile),
          ],
        )
      ),
    );
  }
}
