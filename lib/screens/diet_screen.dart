import 'package:bajar_de_peso_21_dias/theme/app_theme.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class DietScreen extends StatelessWidget {
  const DietScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const List<String> images = [
      "https://media.istockphoto.com/photos/milky-way-over-snowy-mountains-and-lake-at-night-landscape-with-snow-picture-id1328564799?b=1&k=20&m=1328564799&s=170667a&w=0&h=mR6y5dw8z6WzxY-EHChpBAYhm4RbcmvgFNf1ZShzA90=",
      'https://concepto.de/wp-content/uploads/2015/03/paisaje-800x409.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxVVePtoFtJivynibjSda78w87rURn-29YGQ&usqp=CAU',
      'https://i0.wp.com/blog.vivaaerobus.com/wp-content/uploads/2020/04/paisaje-de-los-cabos.jpg?resize=650%2C364&ssl=1',
      'https://2.bp.blogspot.com/-8KuSaGEYEMs/UPSuL75AdoI/AAAAAAAAOLI/8Bb7HfkOQXU/s1600/nuevos+paisajes+floridos+con+carretera.jpg'
    ];

    final customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
      ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
      ..addTranslate([
        const Offset(-370.0, -50.0),
        const Offset(0.0, 0.0),
        const Offset(370.0, -40.0)
      ]);

    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          child: Swiper(
            physics: AppTheme.physics,
            customLayoutOption: customLayoutOption,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                images[index],
                fit: BoxFit.fill,
              );
            },
            itemCount: images.length,
            // itemWidth: 300.0,
            // itemHeight: 300.0,
            // layout: SwiperLayout.STACK,
            loop: false,
            viewportFraction: 0.8,
            scale: 0.9,
          ),
        ),
        Text('data')
      ],
    ));
  }
}
