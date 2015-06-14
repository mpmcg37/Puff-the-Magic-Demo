/**
  
  Dragon  
  Dragon Logic Class responsible for creating the light show on the CC3200 Demo Board.
  
  created 7 June 2015
   by Mitchell McGinnis
*/

int buttonState = 0;
int led1 = 2;
int led2 = 3;

//Prepare the LED's and Pins for the Dragons
void setupDragon() {    
  pinMode(led1, OUTPUT);     
  pinMode(led2, OUTPUT); 
  digitalWrite(led1, LOW); 
  digitalWrite(led2, LOW); 
  pinMode(11, INPUT_PULLUP);
}

//the main dragon loop
void loopDragon() {
  buttonState = digitalRead(11);
  if (mode == 'o'){
    if(DEBUG)
      Serial.println("Off");
    digitalWrite(led1, LOW);               
    digitalWrite(led2, LOW);
  }
  else {
    if(buttonState || mode == 'd'){
      digitalWrite(led1, HIGH);               
      digitalWrite(led2, LOW);  
      delay(40);
      digitalWrite(led1, LOW);              
      digitalWrite(led2, HIGH);
      delay(40);
    }else if(mode == 'p'){
      loopPuff();
    }
    if(DEBUG)
      Serial.println("On");
  }
}

//Slow alternating blinking LED's
void loopPuff(){
    digitalWrite(led1, HIGH);               
    delay(500);
    digitalWrite(led1, LOW);              
    digitalWrite(led2, HIGH);
    delay(500);
    digitalWrite(led2, LOW);
}
