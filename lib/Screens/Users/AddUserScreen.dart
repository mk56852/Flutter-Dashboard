import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:point_of_sales/Screens/Users/widgets/AppTextField.dart';
import 'package:point_of_sales/SharedWidget/AppButton.dart';
import 'package:point_of_sales/SharedWidget/AppContainer.dart';
import 'package:point_of_sales/Utils/AppColors.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserImage(),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight,
                      ),
                      child: AlignedGridView.count(
                        crossAxisCount: 2,
                        itemCount: 6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        itemBuilder: (context, index) {
                          return AppTextField(text: "hello" + index.toString());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UserImage extends StatelessWidget {
  UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 3,
          child: AppContainer(
              width: 300,
              height: 300,
              child: Image.asset(
                "assets/images/choco.png",
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            height: 50,
            width: 280,
            child: AppButton(
                title: "Upload Image",
                bgColor: Appcolors.mainBlue,
                textColor: Colors.white,
                borderColor: Colors.black12,
                onTap: () => print("hello")))
      ],
    );
  }
}
