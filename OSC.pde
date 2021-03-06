/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

void onConnected(int b) {
  p.isConnected = (b==0?false:true);  
}
//
// Initializes the OscP5
void InitOSC(int listen_port, 
             String send_address, int send_port) {
  oscP5 = new OscP5(this, listen_port);
  
  myRemoteLocation = new NetAddress(send_address, send_port);
  
  oscP5.plug(this, "onConnected", "/PY/connected");
}

  

// 
// Send message to remote location
//void SendMessage(String name, float x, float y, float z) {
//  /* in the following different ways of creating osc messages are shown by example */
//  OscMessage myMessage = new OscMessage(name);
//  myMessage.add(x);
//  myMessage.add(y);
//  myMessage.add(z);

//  /* send the message */
//  oscP5.send(myMessage, myRemoteLocation); 
  
//  PrintManager("Message sent=["+x+", "+y+", "+z+"]", 2);
//}
void SendMessage(String name, float x, float y, float z, float speed) {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage(name);
  myMessage.add(nfc(x,3));
  myMessage.add(nfc(y,3));
  myMessage.add(nfc(z,3));
  myMessage.add(speed);

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
  
  //PrintManager("Message sent=["+x+", "+y+", "+z+", "+speed+"]", 2);
}
void SendMessage(String name) {
  OscMessage myMessage = new OscMessage(name);
  oscP5.send(myMessage, myRemoteLocation); 
  
  //PrintManager(name+" sent", 2);
}

//
// incoming osc message are forwarded to the oscEvent method.
void oscEvent(OscMessage _m) {
  //PrintManager("Received osc message: "+_m.address() + " " + _m.typetag(), 2);
  if(_m.checkAddrPattern("/PY/temp")){
    if(_m.checkTypetag("ffff")) {
      p.bed_temp = _m.get(0).floatValue();
      p.bed_temp_target = _m.get(1).floatValue();
      p.nozzle_temp = _m.get(2).floatValue();
      p.nozzle_temp_target = _m.get(3).floatValue();
      return;
    }  
  }
  if(_m.checkAddrPattern("/PY/n_pos")){
    if(_m.checkTypetag("fff")) {
      p.nozzle_pos.x = _m.get(0).floatValue();
      p.nozzle_pos.y = _m.get(1).floatValue();
      p.nozzle_pos.z = _m.get(2).floatValue();
      return;
    }  
  }
}
