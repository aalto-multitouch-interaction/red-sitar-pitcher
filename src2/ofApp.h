#include "ofxiOS.h"
#include "ofxMaxim.h"

class ofApp : public ofxiOSApp{
    
public:
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs & touch);
    void touchMoved(ofTouchEventArgs & touch);
    void touchUp(ofTouchEventArgs & touch);
    void touchDoubleTap(ofTouchEventArgs & touch);
    void touchCancelled(ofTouchEventArgs & touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);
    
    ofVec2f touchPoint;
    ofVec2f knob0pos;
    float radius;
    float rotation;
    
    // sound
    ofSoundPlayer soundPlayer;
    
    void audioOut(ofSoundBuffer& buffer);
    
    // maximillian
    
    maxiOsc osc;
    double frequency, currentSample;
    unsigned bufferSize, sampleRate;

};


