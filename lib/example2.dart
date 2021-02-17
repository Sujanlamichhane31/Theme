import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  
  final imgUrl="https://unsplash.com/photos/Qrjx2nTBHVo/download?force=true";
  bool downloading= false;
  var progressString= "";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadFile();
  }
  
  Future<void> downloadFile() async{
    Dio dio = Dio();
    
    try{
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(imgUrl, "${dir.path}/myimage.jpg",onReceiveProgress: (rec,total){
        print("Rec:$rec, Total: $total");
        print(dir);
        setState(() {
          downloading= true;
          progressString =((rec/total)*100).toStringAsFixed(0)+"%";
        });
      });
    }catch(e){
      print(e);
    }
    setState(() {
      downloading=false;
      progressString="Completed";
      
    });
    print("Download Completed");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
        centerTitle: true,
      ),
      body: Center(
        child: downloading? Container(
          height: 120.0,
          width: 200.0,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10.0,),
                Text("Downloading file: $progressString ",
                style: TextStyle(
                  color: Colors.white
                ),),
              ],
            ),
          ),
        ):Text("No Data"),
      ),
    );
  }
}
