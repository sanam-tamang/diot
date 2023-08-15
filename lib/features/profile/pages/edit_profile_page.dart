import 'dart:typed_data';

import '../../../core/config/theme/app_colors.dart';
import '../../../core/utils/image_picker.dart';
import '../../../core/utils/toast_message.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import 'package:devmandu/core/widgets/show_local_image_file.dart';
import 'package:devmandu/features/profile/blocs/collection_user_du/collection_user_du_cubit.dart';
import 'package:devmandu/features/profile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/size.dart';
import '../../../core/model/user.dart';
import '../../../core/utils/custom_circualr_dialog.dart';
import '../../../core/widgets/build_avatar_image.dart';
import '../../../core/widgets/custom_cache_network_image.dart';
import '../../auth/utils/validator.dart';

import '../model/profile_user_model.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String? networkBackgroundImage;
  Uint8List? backgroundImageFile;
  Uint8List? profileImageFile;
  late TextEditingController nameController;
  late TextEditingController bioController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    networkBackgroundImage = widget.user.backgroudImage;
    nameController = TextEditingController(text: widget.user.name);
    bioController = TextEditingController(text: widget.user.bio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double profileHeaderContainerHight = 240;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit profile"),
          actions: [
            _updateButton(),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: profileHeaderContainerHight,
                  child: LayoutBuilder(builder: (context, constraint) {
                    return Stack(children: [
                      _buildBackgroundImage(constraint),
                      _buildProfileImage(),
                    ]);
                  }),
                ),
                _EditProfileTextField(
                    nameController: nameController,
                    bioController: bioController),
              ],
            ),
          ),
        ));
  }

  BlocListener<CollectionUserDuCubit, CollectionUserDuState> _updateButton() {
    return BlocListener<CollectionUserDuCubit, CollectionUserDuState>(
      listener: (context, state) {
        if (state is CollectionUserDuLoading) {
          circularLoadingDialog(context);
        } else if (state is CollectionUserDuSuccess) {
          Navigator.of(context).pop();
          toastMessage(content: "Profile updated");
          Navigator.of(context).pop();
        } else if (state is CollectionUserDuFailure) {
          Navigator.of(context).pop();
          toastMessage(content: state.message);
        }
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: CustomElevatedButton(
          onPressed: _updateUser,
          label: "Update",
        ),
      ),
    );
  }

  void _updateUser() {
    if (_formKey.currentState?.validate() == true) {
      final user = UpdateProfileUserModel(
          isBackgroundImageDeleted:
              networkBackgroundImage == null ? true : false,
          name: nameController.text.trim(),
          id: widget.user.userId,
          bio: bioController.text,
          profileImage: profileImageFile,
          backgroundImage: backgroundImageFile);

      context.read<CollectionUserDuCubit>().updateUser(user);
    }
  }

  Positioned _buildProfileImage() {
    return Positioned(
      bottom: 0,
      left: 15,
      child: StatefulBuilder(builder: (context, innerSetState) {
        return Stack(
          children: [
            profileImageFile != null
                ? BuildAvatarImageLocal(
                    radius: profileSize,
                    image: profileImageFile,
                  )
                : BuildAvatarImageNetwork(
                    radius: profileSize, image: widget.user.image),
            Positioned.fill(
              child: __reTakeButton(onPressed: () {
                __pickProfileImage(innerSetState);
              }),
            ),
          ],
        );
      }),
    );
  }

  Positioned _buildBackgroundImage(BoxConstraints constraint) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: constraint.maxHeight * 0.68,
        width: double.infinity,
        child: StatefulBuilder(
          builder: (context, innerSetState) => backgroundImageFile != null
              ? Stack(
                  children: [
                    Container(
                      color: AppColors.greyScale6,
                      child: ShowLocalImageFile(
                        fit: BoxFit.cover,
                        aspectRadio: 5 / 2,
                        deleteImage: () {
                          innerSetState(() {
                            backgroundImageFile = null;
                          });
                        },
                        imageFile: backgroundImageFile,
                      ),
                    ),
                    Positioned.fill(
                      child: __reTakeButton(onPressed: () {
                        ___pickBackgroundImage(innerSetState);
                      }),
                    ),
                  ],
                )
              : __showBackgroundImage(innerSetState),
        ),
      ),
    );
  }

  Center __reTakeButton({required VoidCallback onPressed}) {
    return Center(
      child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white.withOpacity(0.4),
          child: Center(
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.change_circle_outlined),
              iconSize: 32,
            ),
          )),
    );
  }

  Stack __showBackgroundImage(StateSetter innerSetState) {
    return Stack(fit: StackFit.expand, children: [
      CustomCacheNetworkImage(
        fit: BoxFit.cover,
        imageUrl: networkBackgroundImage,
      ),
      Positioned.fill(
        child: __reTakeButton(onPressed: () {
          ___pickBackgroundImage(innerSetState);
        }),
      ),
      networkBackgroundImage != null
          ? Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                  onPressed: () {
                    innerSetState(() {
                      networkBackgroundImage = null;
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            )
          : const SizedBox(),
    ]);
  }

  Future<void> ___pickBackgroundImage(StateSetter innerSetState) async {
    final byte = await CustomPicker.imageFile();
    backgroundImageFile = byte;
    innerSetState(() {});
  }

  Future<void> __pickProfileImage(StateSetter innerSetState) async {
    final byte = await CustomPicker.imageFile();
    profileImageFile = byte;
    innerSetState(() {});
  }
}

class _EditProfileTextField extends StatelessWidget {
  const _EditProfileTextField({
    required this.nameController,
    required this.bioController,
  });

  final TextEditingController nameController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTffProfile(
            textCapitalization: TextCapitalization.words,
            hintText: 'Enter your full name',
            controller: nameController,
            label: 'Name',
            validator: Validator.validateFullName,
            maxLength: 35,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTffProfile(
            textInputType: TextInputType.multiline,
            hintText: 'Write about yourself...',
            controller: bioController,
            label: 'Bio',
            maxLength: 160,
            maxLines: 6,
          ),
        ],
      ),
    );
  }
}
