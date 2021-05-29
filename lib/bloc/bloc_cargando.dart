



import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class BlocCargando extends ChangeNotifier {
  ValueNotifier<bool> _cargando = ValueNotifier(false);
  ValueNotifier<bool> get cargando => this._cargando; 


  @override
  void dispose() {
    super.dispose();
  }

  void setValor(bool value) => this._cargando.value = value;  
}
