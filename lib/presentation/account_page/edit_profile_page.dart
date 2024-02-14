
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_x/data_layer/models/user_details_model.dart';
import 'package:shop_x/logic_layer/authentication/authentication_bloc.dart';
import 'package:shop_x/presentation/account_page/widgets/toast_widget.dart';
import 'package:shop_x/utils/form_helper.dart';
import 'package:sizer/sizer.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool readOnly = false;

  void initialCustomerData(CustomerDetailsModel customer) {
    _fnameController.text = customer.firstName ?? "Nil";
    _lnameController.text = customer.lastName ?? "Nil";
    _addressController.text = customer.shipping?.address ?? "Nil";
    _cityController.text = customer.shipping?.city ?? "Nil";
    _pincodeController.text = customer.shipping?.postCode ?? "Nil";
    _phoneController.text = customer.billing?.phone ?? "Nil";
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthenticationBloc>().add(LoadCustomerDetails());
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticatedCustomerDetails) {
              final customerDetails = state.customerModel;

              initialCustomerData(customerDetails);

              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FormHelper.fieldLabel(
                                          context, 'First Name'),
                                      SizedBox(height: 1.h),
                                      FormHelper.textInputField(
                                          controller: _fnameController,
                                          hintText: 'Enter First Name',
                                          readOnly: context
                                              .watch<AuthenticationBloc>()
                                              .readOnly),
                                    ]),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FormHelper.fieldLabel(
                                          context, 'Last Name'),
                                      SizedBox(height: 1.h),
                                      FormHelper.textInputField(
                                          controller: _lnameController,
                                          hintText: 'Enter Last Name',
                                          readOnly: context
                                              .watch<AuthenticationBloc>()
                                              .readOnly),
                                    ]),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          FormHelper.fieldLabel(context, 'City'),
                          SizedBox(height: 1.h),
                          FormHelper.textInputField(
                              controller: _cityController,
                              hintText: 'Enter City',
                              readOnly:
                                  context.watch<AuthenticationBloc>().readOnly),
                          SizedBox(height: 2.h),
                          FormHelper.fieldLabel(context, 'Address'),
                          SizedBox(height: 1.h),
                          FormHelper.textInputField(
                              controller: _addressController,
                              hintText: 'Enter Address',
                              readOnly:
                                  context.watch<AuthenticationBloc>().readOnly),
                          SizedBox(height: 2.h),
                          FormHelper.fieldLabel(context, 'Pincode'),
                          SizedBox(height: 1.h),
                          FormHelper.textInputField(
                              controller: _pincodeController,
                              hintText: 'Enter Pincode',
                              readOnly:
                                  context.watch<AuthenticationBloc>().readOnly),
                          SizedBox(height: 2.h),
                          FormHelper.fieldLabel(context, 'Phone'),
                          SizedBox(height: 1.h),
                          FormHelper.textInputField(
                              controller: _phoneController,
                              hintText: 'Enter Phone',
                              readOnly:
                                  context.watch<AuthenticationBloc>().readOnly),
                          SizedBox(height: 3.h),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: 10.sp,
                                            vertical: 10.sp)),
                                    shape: const MaterialStatePropertyAll(
                                        StadiumBorder())),
                                onPressed: () {
                                  final customerModel = CustomerDetailsModel(
                                      firstName: _fnameController.text.trim(),
                                      lastName: _lnameController.text.trim(),
                                      shipping: Shipping(
                                          company:
                                              customerDetails.shipping?.company,
                                          city: _cityController.text.trim(),
                                          address:
                                              _addressController.text.trim(),
                                          postCode:
                                              _pincodeController.text.trim()),
                                      billing: Billing(
                                          phone: _phoneController.text.trim()));

                                  readOnly =
                                      BlocProvider.of<AuthenticationBloc>(
                                              context,
                                              listen: false)
                                          .readOnly;
                                  if (readOnly == false) {
                                    showToastMessage('Profile Updated');
                                  }

                                  context.read<AuthenticationBloc>().add(
                                      EditCustomerDetails(
                                          updateCustomer: readOnly == false
                                              ? customerModel
                                              : null));
                                },
                                child: Text(
                                  BlocProvider.of<AuthenticationBloc>(context,
                                              listen: false)
                                          .readOnly
                                      ? 'Edit Profile'
                                      : 'Save',
                                  style: TextStyle(
                                      fontFamily: 'Lato', fontSize: 10.sp),
                                )),
                          )
                        ]),
                  ),
                ),
              );
            } else if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('No Data'));
            }
          },
         
        ),
      ),
    );
  }
}
