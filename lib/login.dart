import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'users_list.dart';

class LoginPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType{
  login,
  Register
}

  class _LoginPageState extends State<LoginPage>{

  final formKey = new GlobalKey<FormState>();
  final db = Firestore.instance;

  String _fName;
  String _lName;
  String _userName;
  String _mobile;
  String _gender;
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    form.save();
    if(form.validate())
      return true;

      return false;
  }

  void validateAndSubmit() async{
    if(validateAndSave()) {
      try {
        if (_formType == FormType.login){

          AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print('signed in : ${result.user.uid}');
          if (result.user.uid != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ListPage()),
            );
      }
        }
        else{
          AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
          //print('registerd user: ${user.uid}');
            await db.collection("users").document(_email).setData({'Fname': _fName, 'Lname': _lName, 'user name': _userName,'mobile': _mobile,'Gender': _gender});
          print('registrerd user: ${result.user.uid}');
          if (result.user.uid != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPage()),
            );
          }
          else{

          }


        }
    }
      catch(e){
        print('Error: $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
        _formType = FormType.Register;
    });

  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      
      appBar: new AppBar(
        title: new Text('Melat',
        ),
      ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
                buildInputs()+buildSubmitButton(),
            ),
          ),
        ),
    );
  }

  List<Widget> buildInputs(){
    if(_formType == FormType.login) {
      return [
        new TextFormField(
         
          decoration: new InputDecoration(
            prefixIcon: Icon(Icons.email),
   hintText: "Email",
    
   hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),  
     ),
          ),
          
          validator: (value) => value.isEmpty ? 'Please fill the Email' : null,
          onSaved: (value) => _email = value,
     
        ),
        SizedBox(height:10),
        new TextFormField(
          decoration: new InputDecoration(
         prefixIcon: Icon(Icons.lock),
           hintText: "Password",
       hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
      
      borderRadius: BorderRadius.circular(20.0),  
     ),
          ),
              obscureText: true,
          validator: (value) =>
          value.isEmpty
              ? 'Please fill the Password'
              : null,
          onSaved: (value) => _password = value,
        ),
      ];
    }
    else{
      return [
        new TextFormField(
          decoration: new InputDecoration(
  prefixIcon: Icon(Icons.person),
   hintText: "FirstName",
   hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
     
      borderRadius: BorderRadius.circular(20.0),  
     ),),
          validator: (value) => value.isEmpty ? 'fill first name please' : null,
          onSaved: (value) => _fName = value,
        ),
        SizedBox(height:5),
        new TextFormField(
          decoration: new InputDecoration(
             prefixIcon: Icon(Icons.person),
   hintText: 'Last Name',
   hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),  
     ),),
          validator: (value) => value.isEmpty ? 'fill lastname please' : null,
          onSaved: (value) => _lName = value,
        ),
        SizedBox(height:5),
        new TextFormField(
          decoration: new InputDecoration(
          

   hintText: 'User Name',
   hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
     ),),
          validator: (value) => value.isEmpty ? 'fill user name please' : null,
          onSaved: (value) => _userName = value,
        ),
        SizedBox(height:5),
        new TextFormField(
          decoration: new InputDecoration(
              prefixIcon: Icon(Icons.email),
       hintText: 'Email',
       hintStyle: TextStyle(
       
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
    
      borderRadius: BorderRadius.circular(20),
     ),),
          validator: (value) => value.isEmpty ? 'fill email please' : null,
          onSaved: (value) => _email = value,
        ),
        SizedBox(height:20),
        new TextFormField(
          decoration: new InputDecoration(
           prefixIcon: Icon(Icons.phone),
   hintText: 'Phone Number',
   hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
       
      borderRadius: BorderRadius.circular(20),
     ),),
          validator: (value) => value.isEmpty ? 'fill phone number please' : null,
          onSaved: (value) => _mobile = value,
        ),
        SizedBox(height:5),
        new TextFormField(
          decoration: new InputDecoration(
   hintText: 'Gender',
   hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
      
      borderRadius: BorderRadius.circular(20.0),  
     ),),
          validator: (value) => value.isEmpty ? 'fill gender please' : null,
          onSaved: (value) => _gender = value,
        ),
        SizedBox(height:20),
        new TextFormField(
          decoration: new InputDecoration(
   hintText: 'Password',
   hintStyle: TextStyle(
     color: Colors.black,
     fontSize: 16.0,),//textstyle
     border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),  
     ),),
          obscureText: true,
          validator: (value) => value.isEmpty ? 'fill password please' : null,
          onSaved: (value) => _password = value,
        ),
      ];
    }
  }
  List<Widget> buildSubmitButton(){

    if(_formType == FormType.login) {
      return [
        new RaisedButton(
          shape: const StadiumBorder(),
          color: Colors.purpleAccent,
          child: new Text('Login', style: new TextStyle(
            fontSize: 30.0,
            color: Colors.white),),
           
          onPressed: validateAndSubmit,
        ),
        SizedBox(height:5.0),
        new FlatButton(
          shape: const StadiumBorder(),
          color: Colors.purpleAccent,
          child: new Text(
            'create an account', style: new TextStyle(
            color: Colors.white,
              fontSize: 20.0,
              ),),
          onPressed: moveToRegister,
        )
      ];
    }
    else{
      return [
        new RaisedButton(
          shape: const StadiumBorder(),
          color: Colors.purpleAccent,
          splashColor : Colors.cyan,
          child: new Text('create an account', 
          style: new TextStyle(fontSize: 20.0,
          color: Colors.white), 

          ),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          splashColor: Colors.cyan,
          child: new Text(
            ' have an acount? Login', 
            style: new TextStyle(fontSize: 20.0),
            ),
          onPressed: moveToLogin,
        )
      ];
    }
  }

}