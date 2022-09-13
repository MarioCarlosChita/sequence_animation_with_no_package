import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late AnimationController _animationController2;
  late Animation<Offset> _offset;
  late Animation<double> _oppacity;
  late Animation<Offset> _offsetTop;

  initState(){
    _animationController = AnimationController(vsync: this, duration:const  Duration(seconds:4));

    _offset  = Tween<Offset>(begin: const Offset(-200, 120), end:const Offset(40,120))
    .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _oppacity =Tween<double>(begin: 1, end:0)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

   _animationController2 =  AnimationController(vsync: this, duration:const  Duration(seconds:4));

    _offsetTop = Tween<Offset>(begin: const Offset(70,120) , end: const Offset(70,-200))
        .animate(CurvedAnimation(parent: _animationController2, curve: Curves.linear));

    _animationController.addStatusListener((status) {
       if (status == AnimationStatus.completed){
          _animationController2.forward();
       }
    });

    super.initState();

  }
  void dispose(){
    _animationController.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [

              AnimatedBuilder(
                  animation: _animationController,
                  builder: (context , child){
                    return AnimatedOpacity(
                        opacity: _oppacity.value,
                        duration: const Duration(milliseconds:500),
                        child: child,
                    );
                  },
                 child: AnimatedBuilder(
                    animation:_animationController,
                    builder: (context , child){
                       return  Transform.translate(
                         offset: _offset.value,
                         child: child,
                       );
                    },
                   child: AnimatedBuilder(
                     animation: _animationController2,
                     builder: (context, child){
                       return Transform.translate(
                         offset:_offsetTop.value,
                         child:child
                       );
                     },
                     child: Container(
                       width: 120,
                       height: 120,
                       color: Colors.red,
                     ),
                   ),
                 ),
              ),
              MaterialButton(
                onPressed: (){
                   _animationController.forward();
                },
                color: Colors.blue,
                minWidth: 120,
                height:40,
                child: const Text("Play", style:TextStyle(color: Colors.white),),
              )

           ],
        ),
      ),
    );
  }
}
