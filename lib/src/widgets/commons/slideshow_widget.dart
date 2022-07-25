import 'package:appetit/constants.dart';
import 'package:appetit/src/widgets/buttons/rounded_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// MODELO DE DATOS PRIVADOS PARA EL PROVIDER
class _SliderModel with ChangeNotifier {

  // INSTANCIAS
  double _currentPage = 0;
  Color _colorPrimario = Colors.grey;
  Color _colorSecundario = Colors.blue;
  int _dotSizeSelect = 16;
  int _dotSizeNormal = 12;
  late List<String> _titles;
  late List<String> _descriptions;
  late int _slidersCount;

  // SETTERS Y GETTERS
  double get currentPage {
    return this._currentPage;
  }

  set currentPage (double currentPage) {
    this._currentPage = currentPage;
    notifyListeners();
  }

  Color get colorPrimario => this._colorPrimario;
  set colorPrimario (Color colorPrimario) {
    this._colorPrimario = colorPrimario;
  }

  Color get colorSecundario => this._colorSecundario;
  set colorSecundario (Color colorSecundario) {
    this._colorSecundario = colorSecundario;
  }

  int get dotSizeSelect => this._dotSizeSelect;
  set dotSizeSelect (int dotSizeSelect) {
    this._dotSizeSelect = dotSizeSelect;
  }

  int get dotSizeNormal => this._dotSizeNormal;
  set dotSizeNormal (int dotSizeNormal) {
    this._dotSizeNormal = dotSizeNormal;
  }

  List<String> get titles {
    return this._titles;
  }

  set titles (List<String> titles) {
    this._titles = titles;
    this._slidersCount = titles.length;
  }

  List<String> get descriptions {
    return this._descriptions;
  }

  set descriptions (List<String> descriptions) {
    this._descriptions = descriptions;
  }

  int get slidersCount => this._slidersCount;
}

// CLASE PRINCIPAL
class Slideshow extends StatelessWidget {

  // CONSTRUCTOR
  final List<Widget> slides;
  final bool dotsTop;
  final Color? dotsColor;
  final Color? dotColorSelect;
  final int? dotSizeSelect;
  final int? dotSizeNormal;
  final List<String> titles;
  final List<String> descriptions;
  final Function finalsliderbutton;

  Slideshow({
    required this.slides, 
    this.dotsTop = false, 
    this.dotsColor, 
    this.dotColorSelect,
    this.dotSizeSelect,
    this.dotSizeNormal,
    required this.titles,
    required this.descriptions,
    required this.finalsliderbutton,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SliderModel(),
      child: Center(
        child: Builder(
          builder: (BuildContext context) {
            Provider.of<_SliderModel>(context).colorPrimario = this.dotColorSelect!;
            Provider.of<_SliderModel>(context).colorSecundario = this.dotsColor!;
            Provider.of<_SliderModel>(context).dotSizeSelect = this.dotSizeSelect!;
            Provider.of<_SliderModel>(context).dotSizeNormal = this.dotSizeNormal!;
            Provider.of<_SliderModel>(context).titles = this.titles;
            Provider.of<_SliderModel>(context).descriptions = this.descriptions;
            return _CreateEstructure(dotsTop: dotsTop, slides: slides, finalsliderbutton: this.finalsliderbutton);
          }
        ),
      ),
    );
  }
}

// ESTRUCTURA DEL SLIDER
class _CreateEstructure extends StatelessWidget {

  // CONSTRUCTOR
  final bool dotsTop;
  final List<Widget> slides;
  final Function? finalsliderbutton;

  const _CreateEstructure({
    required this.dotsTop,
    required this.slides,
    this.finalsliderbutton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (this.dotsTop) _Dots(this.slides.length),
        Expanded(
          child: _Slides(this.slides, this.finalsliderbutton)
        ),
        if (!this.dotsTop) _Dots(this.slides.length),
      ],
    );
  }
}

// CREADOR DE LOS PUNTOS
class _Dots extends StatelessWidget {

  // CONSTRUCTOR
  final int slidesCount;

  const _Dots(
    this.slidesCount,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 7.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(this.slidesCount, (index) => _Dot(index)),
      ),
    );
  }
}

// CREADOR DE UN PUNTO
class _Dot extends StatelessWidget {

  // CONSTRUCTOR
  final int index;

  const _Dot(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SliderModel>(context);
    double finalSize = 0.0;
    Color finalDotColor;
    if (ssModel.currentPage >= index - 0.5 && ssModel.currentPage < index + 0.5) {
      finalSize = ssModel._dotSizeSelect.toDouble();
      finalDotColor = ssModel._colorPrimario;
    } else {
      finalSize = ssModel._dotSizeNormal.toDouble();
      finalDotColor = ssModel._colorSecundario;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: finalSize,
      height: finalSize,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: finalDotColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

// CREADOR DE LOS SLIDERS
class _Slides extends StatefulWidget {

  // CONSTRUCTOR
  final List<Widget> slides;
  final finalsliderbutton;

  const _Slides(
    this.slides,
    this.finalsliderbutton,
  );

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {

  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      Provider.of<_SliderModel>(context, listen: false).currentPage = pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: pageViewController,
        children: widget.slides.map((element) {
          final int index = widget.slides.indexOf(element);
          final String theTitle = Provider.of<_SliderModel>(context, listen: false).titles[index];
          final String theDescription = Provider.of<_SliderModel>(context, listen: false).descriptions[index];
          return _Slide(element, theTitle, theDescription, index, widget.finalsliderbutton);
        }).toList(),
      ),
    );
  }
}

// CLASE DEL SLIDER
class _Slide extends StatelessWidget {

  final Widget slide;
  final String title;
  final String description;
  final int theSlider;
  final finalsliderbutton;

  const _Slide(
    this.slide,
    this.title,
    this.description,
    this.theSlider,
    this.finalsliderbutton,
  );

  @override
  Widget build(BuildContext context) {

    final totalSliders = Provider.of<_SliderModel>(context).slidersCount - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              child: slide,
            ),
          ),
          Text(
            this.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              color: kPrimaryColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: kDefaultPadding / 2,
          ),
          Text(
            this.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: kSpecialTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: kDefaultPadding*2-10,
          ),
          if (totalSliders == theSlider) Container(
            alignment: Alignment.bottomCenter,
            width: double.infinity,
            height: 60,
            child: RoundedBtnWidget(
              btnAccion: this.finalsliderbutton,
              btnText: tr('general_btn_understood'),
            ),
          ),
        ],
      ),
    );
  }
}