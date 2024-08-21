import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prophub/src/state/onboarding/state_notifiers/onboarding_state_notifier.dart';
import 'package:prophub/src/theme/app_colors.dart';
import 'package:prophub/src/utilities/enums/agent_type.dart';
import 'package:prophub/src/utilities/navigation/navigator.dart';
import 'package:prophub/src/utilities/permission_handler/m_permissions_handler.dart';
import 'package:prophub/src/utilities/widgets/action_sheet.dart';

import '../../../../../utilities/constants/app_constants.dart';
import '../../../../../widgets/bottons/app_buttons.dart';
import '../../../../../widgets/text_input/ProphubDropDown.dart';
import '../../../../../widgets/text_input/ProphubTextfield.dart';

class Address extends ConsumerStatefulWidget {
  const Address({super.key});

  @override
  ConsumerState<Address> createState() => _AddressState();
}

class _AddressState extends ConsumerState<Address> with MPermissionHandler {
  final addressFormKey = GlobalKey<FormState>();

  final _agentType = DropdownFieldController();
  final _streetAddress = TextEditingController();
  final _stateAddress = DropdownFieldController();
  final _lgaAddress = DropdownFieldController();
  final _cacNumber = TextEditingController();
  final _officeAddress = TextEditingController();

  ValueNotifier<String?> documentValidationError = ValueNotifier(null);
  ValueNotifier<String?> documentSelectionError = ValueNotifier(null);
  ValueNotifier<File?> proofOfAddressFile = ValueNotifier(null);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onBoardingProvider.notifier).initialize();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final provider = ref.read(onBoardingProvider);

    _agentType.text = provider.addressForm.agentRegistrationType.isValid ? provider.addressForm.agentRegistrationType.getOrCrash().value : '';
    _streetAddress.text = provider.addressForm.officeAddress!.isValid ? provider.addressForm.officeAddress!.getOrCrash() : '';
    _stateAddress.text = provider.addressForm.addressState.isValid ? provider.addressForm.addressState.getOrCrash() : '';
    _lgaAddress.text = provider.addressForm.addressLga.isValid ? provider.addressForm.addressLga.getOrCrash() : '';
    _cacNumber.text = provider.addressForm.cacNumber.isValid ? provider.addressForm.cacNumber.getOrCrash() : '';
    _officeAddress.text = provider.addressForm.officeAddress!.isValid ? provider.addressForm.officeAddress!.getOrCrash() : '';
    if(provider.addressForm.professionalCertification!.isValid) {
      proofOfAddressFile.value = File(provider.addressForm.professionalCertification!.getOrCrash());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _agentType.dispose();
    _streetAddress.dispose();
    _stateAddress.dispose();
    _lgaAddress.dispose();
    _cacNumber.dispose();
    _officeAddress.dispose();
    proofOfAddressFile.dispose();
    documentSelectionError.dispose();
    documentValidationError.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(onBoardingProvider);
    final providerAction = ref.watch(onBoardingProvider.notifier);
    return SingleChildScrollView(
      child: Form(
          key: addressFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: Constants.guttterXXl,
              ),
              FormCustomDropdownField(
                initialValue: _agentType.text,
                dropIconColor: Colors.white54,
                backgroundColor: Colors.transparent,
                items: AgentType.values.map((e) => e.value).toList(),
                hintText: 'Agent Type',
                onChanged: providerAction.setAgentType,
                validator: (_) =>
                    provider.addressForm.agentRegistrationType.failureOrNone.fold(() => null, (value) => value.message),
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              PropHubTextField(
                controller: _streetAddress,
                title: 'Street',
                color: Colors.transparent,
                onChanged: providerAction.setStreetAddress,
                validator: (_) => ref
                    .watch(onBoardingProvider.select((value) => value.addressForm))
                    .street
                    .failureOrNone
                    .fold(() => null, (value) => value.message),
                onEditingComplete: () => ref
                    .watch(onBoardingProvider.select((value) => value.addressForm))
                    .street
                    .failureOrNone
                    .fold(() => FocusScope.of(context).nextFocus(), (value) {}),
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              Builder(builder: (context) {
                if (provider.states != null) {
                  return FormCustomDropdownField(
                    initialValue: _stateAddress.text,
                    dropIconColor: Colors.white54,
                    backgroundColor: Colors.transparent,
                    items: provider.states!.map((e) => e.state.name).toList(),
                    hintText: 'State',
                    onChanged: providerAction.onStateChange,
                    validator: (_) =>
                        provider.addressForm.addressState.failureOrNone.fold(() => null, (value) => value.message),
                  );
                } else {
                  return FormCustomDropdownField(
                    dropIconColor: Colors.white54,
                    backgroundColor: Colors.transparent,
                    items: const [],
                    hintText: 'State',
                    onChanged: providerAction.onStateChange,
                    validator: (_) =>
                        provider.addressForm.addressState.failureOrNone.fold(() => null, (value) => value.message),
                  );
                }
              }),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              Builder(builder: (context) {
              if (provider.isStateSelected) {
                return FormCustomDropdownField(
                  initialValue: _lgaAddress.text,
                  dropIconColor: Colors.white54,
                  backgroundColor: Colors.transparent,
                  items: provider.states!
                      .firstWhere(
                          (element) => element.state.name == provider.addressForm.addressState.getOrCrash())
                      .state
                      .locals,
                  hintText: 'LGA',
                  onChanged: providerAction.onLgaChange,
                  validator: (_) =>
                      provider.addressForm.addressLga.failureOrNone.fold(() => null, (value) => value.message),
                );}
              return FormCustomDropdownField(
                dropIconColor: Colors.white54,
                backgroundColor: Colors.transparent,
                items: const [],
                hintText: 'LGA',
                onChanged: providerAction.onLgaChange,
                validator: (_) => '',
              );
              }),
              const SizedBox(
                height: Constants.gutterXl,
              ),
              PropHubTextField(
                controller: _cacNumber,
                title: 'CAC Number',
                color: Colors.transparent,
                onChanged: providerAction.cacNumberOnchange,
                validator: (_) => ref
                    .watch(onBoardingProvider.select((value) => value.addressForm))
                    .cacNumber
                    .failureOrNone
                    .fold(() => null, (value) => value.message),
                onEditingComplete: () => ref
                    .watch(onBoardingProvider.select((value) => value.addressForm))
                    .cacNumber
                    .failureOrNone
                    .fold(() => FocusScope.of(context).nextFocus(), (value) {}),
              ),
              if(provider.addressForm.agentRegistrationType.failureOrNone.isNone()) ...[
                const SizedBox(
                  height: Constants.gutterXl,
                ),
                () {
                  if({AgentType.surveyor, AgentType.architect, AgentType.legalDraftsman}.contains(provider.addressForm.agentRegistrationType.getOrCrash())){
                    return Column(
                      children: [
                        PropHubTextField(
                          controller: _officeAddress,
                          title: 'Office Address',
                          color: Colors.transparent,
                          onChanged: providerAction.officeAddressOnchange,
                          validator: (_) => ref
                              .watch(onBoardingProvider.select((value) => value.addressForm))
                              .officeAddress!
                              .failureOrNone
                              .fold(() => null, (value) => value.message),
                          onEditingComplete: () => ref
                              .watch(onBoardingProvider.select((value) => value.addressForm))
                              .officeAddress!
                              .failureOrNone
                              .fold(() => FocusScope.of(context).nextFocus(), (value) {}),
                        ),
                        const SizedBox(
                          height: Constants.gutterXl,
                        ),
                        InkWell(
                          onTap: () async {
                            documentSelectionError.value = null;

                            await mediaLibraryRequestHandler(() {
                              if (Platform.isAndroid) {
                                // fileUploadCubit.pickFile();
                                pickFile();
                                return;
                              }
                              selectDocumentAction();
                            });
                          },
                          child: ValueListenableBuilder<String?>(
                            valueListenable: documentSelectionError,
                            builder: (_, value, __) {
                              return Padding(padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DottedBorder(
                                    color: value != null ? AppColors.error : Colors.white,
                                    strokeWidth: 2,
                                    dashPattern: const [7, 3],
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(8),
                                    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: mecuryGrey)),
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.add,
                                            color: paleSkyGrey,
                                            size: 10.r,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: proofOfAddressFile,
                                          builder: (context, File? file, _) {
                                            return Flexible(
                                              flex: 2,
                                              child: Text(
                                                file?.path.split('/').last ?? 'Upload Professional Certification',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  if (value != null) ...[
                                    SizedBox(height: 10.h),
                                    Text(
                                      value,
                                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                                    ),
                                  ]
                                ],
                              )
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: Constants.gutterXl,
                        ),
                    ],);
                  }
                  return const SizedBox.shrink();
                }()
              ] else const SizedBox(
                height: Constants.gutterXl,
                ),
              SizedBox(
                width: width(context) - 40,
                child: PropFlatButton(
                  isDisabled: ValueNotifier(providerAction.disableAddressBtn()),
                  title: 'Next',
                  onTap: () => providerAction.nextPage(),
                  buttonColor: Colors.blueGrey,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: Constants.gutterXl,
              ),
            ],
          )),
    );
  }

  void selectDocumentAction() {
    showPlatformActionSheet(
      context: context,
      actions: [
        CupertinoActionSheetAction(
          child: const Text(
            'Pick an Image',
            style: TextStyle(
              color: AppColors.primaryMerchant01,
            ),
          ),
          onPressed: () {
            context.pop();
            pickImageFile();
            // fileUploadCubit.pickImageFile();
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Pick File',
            style: TextStyle(
              color: AppColors.primaryMerchant01,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            pickFile();
          },
        ),
      ],
    );
  }

  void pickImageFile() async {
    ///FilePicker Implementation
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
      preferredCameraDevice: CameraDevice.front,
    );
    if (image == null) return;
    try {
      ///Access the file
      File file = File(image.path);
      proofOfAddressFile.value = file;
      ref.watch(onBoardingProvider.notifier).setProfessionalCertification(file);
    } catch (e) {
      documentSelectionError.value = e.toString();
    }
  }

  void pickFile() async {
    try {
      ///Access the file
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      File file = File(result.files.first.path!);
      ref.watch(onBoardingProvider.notifier).setProfessionalCertification(file);
      proofOfAddressFile.value = file;
    } on PlatformException catch (e) {
      documentSelectionError.value = e.message;
    } catch (e) {
      documentSelectionError.value = e.toString();
    }
  }
}
