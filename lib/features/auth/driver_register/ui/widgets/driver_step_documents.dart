import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:satha/generated/locale_keys.g.dart';
import 'package:satha/features/auth/driver_register/logic/driver_register_cubit.dart';
import 'package:satha/features/auth/widgets/document_upload_card.dart';

/// الخطوة 3 من تسجيل السائق — رفع المستندات.
class DriverStepDocuments extends StatelessWidget {
  final DriverRegisterCubit cubit;
  const DriverStepDocuments({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DocumentUploadCard(
          title: LocaleKeys.nationalIdFront.tr(),
          file: cubit.documents[DriverDocType.idFront],
          onPick: () => cubit.pickDocument(DriverDocType.idFront),
          onRemove: () => cubit.removeDocument(DriverDocType.idFront),
        ),
        DocumentUploadCard(
          title: LocaleKeys.nationalIdBack.tr(),
          file: cubit.documents[DriverDocType.idBack],
          onPick: () => cubit.pickDocument(DriverDocType.idBack),
          onRemove: () => cubit.removeDocument(DriverDocType.idBack),
        ),
        DocumentUploadCard(
          title: LocaleKeys.drivingLicenseImage.tr(),
          file: cubit.documents[DriverDocType.license],
          onPick: () => cubit.pickDocument(DriverDocType.license),
          onRemove: () => cubit.removeDocument(DriverDocType.license),
        ),
        DocumentUploadCard(
          title: LocaleKeys.vehicleLicenseImage.tr(),
          file: cubit.documents[DriverDocType.vehicleLicense],
          onPick: () => cubit.pickDocument(DriverDocType.vehicleLicense),
          onRemove: () => cubit.removeDocument(DriverDocType.vehicleLicense),
        ),
        DocumentUploadCard(
          title: LocaleKeys.additionalPermit.tr(),
          isRequired: false,
          file: cubit.documents[DriverDocType.permit],
          onPick: () => cubit.pickDocument(DriverDocType.permit),
          onRemove: () => cubit.removeDocument(DriverDocType.permit),
        ),
      ],
    );
  }
}
