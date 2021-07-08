import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PictureWidgets extends StatelessWidget {
  double width;
  double height;
  String image;

  PictureWidgets(this.width, this.height, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ImgOrSvg(),
    );
  }

  /// Esse metodo tem a função de descobre se a imagem é um svg do aplicativo
  /// ou é uma foto de carregado do servidor
  Widget ImgOrSvg() {
    /// teste se a string da imagem contem uma url
    /// o contrains faz a busca dessa url no caminha da imagem, contendo retonara
    /// um Image.Network
    if (image.contains('https') || image.contains('http')) {
      return Image.network(image);
    } else {
      /// caso não seja, é uma imagem do sistemas. Retornara a configuração para tau
      return SvgPicture.asset(image);
    }
  }
}
