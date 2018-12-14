#include "ofApp.h"
#include "ofxMaxim.h"


//--------------------------------------------------------------
void ofApp::setup(){	
    ofBackgroundHex(0xFA0000);
    ofSetCircleResolution(100);
    knob0pos.set(ofGetWidth() / 2, ofGetHeight() / 2 - 200);
    radius = 100;
    rotation = 0;
    soundPlayer.load("hohoho.mp3");
    soundPlayer.setMultiPlay(true);
    
    
    // maximillian
    sampleRate = 44100;
    bufferSize = 512;
    frequency = 440;
    ofSoundStreamSetup(2, 0, this, sampleRate, bufferSize, 4);

}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(0);
    // shadow
//    ofVec2f shadow = ofVec2f(
//         ofGetWidth() / 2 + (touchPoint.x - ofGetWidth()/2) * 1.25,
//         ofGetHeight() / 2 + (touchPoint.y - ofGetHeight()/2) * 1.25
//     );
//    ofDrawCircle(shadow, radius);
    ofSetColor(255);
    
    ofPushMatrix();
        ofTranslate(knob0pos.x, knob0pos.y);
        ofRotateZDeg(rotation);
        // circle
        ofDrawCircle(0,0, radius);
        // knob
        ofDrawCircle(0, 0 - radius, radius / 3);
    
    ofPopMatrix();
    
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    touchPoint = ofVec2f(touch.x, touch.y);
    cout << "hohoho" << endl;
    soundPlayer.play();

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    rotation = touchPoint.distance(touch);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

