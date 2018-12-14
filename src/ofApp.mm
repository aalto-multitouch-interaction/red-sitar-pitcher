#include "ofApp.h"
#include "ofxMaxim.h"

//--------------------------------------------------------------
void ofApp::setup(){
    
    // SOUND
    
    sender.setup(HOST, PORT);
    /* some standard setup stuff*/
    ofEnableAlphaBlending();
    ofSetupScreen();
    ofBackground(255, 0, 0);
    ofSetCircleResolution(100);
    ofSetFrameRate(60);
    
    /* This is stuff you always need.*/
    
    sampleRate 			= 44100; /* Sampling Rate */
    initialBufferSize	= 512;	/* Buffer Size. you have to fill this buffer with sound*/
    lAudioOut			= new float[initialBufferSize];/* outputs */
    rAudioOut			= new float[initialBufferSize];
    lAudioIn			= new float[initialBufferSize];/* inputs */
    rAudioIn			= new float[initialBufferSize];
    
    
    /* This is a nice safe piece of code */
    memset(lAudioOut, 0, initialBufferSize * sizeof(float));
    memset(rAudioOut, 0, initialBufferSize * sizeof(float));
    
    memset(lAudioIn, 0, initialBufferSize * sizeof(float));
    memset(rAudioIn, 0, initialBufferSize * sizeof(float));
    
    /* Now you can put anything you would normally put in maximilian's 'setup' method in here. */
    
//    samp.load(ofToDataPath("hohoho.wav"));
    samp.load(ofToDataPath("sitar.wav"));
    samp2.load(ofToDataPath("sitar.wav"));
    cout << samp.getSummary() << endl;
    cout << samp.getLength() << endl;

    
    
    fftSize = 1024;
    mfft.setup(fftSize, 512, 256);
    ifft.setup(fftSize, 512, 256);
    
    
    nAverages = 12;
    oct.setup(sampleRate, fftSize/2, nAverages);
    
    mfccs = (double*) malloc(sizeof(double) * 13);
    mfcc.setup(512, 42, 13, 20, 20000, sampleRate);
    
    ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
    ofSoundStreamSetup(2,2, this, sampleRate, initialBufferSize, 4);/* Call this last ! */
    
    ofSetVerticalSync(true);
    
    // touch
    touchPoint = ofVec2f(ofGetWidth() / 2,ofGetHeight() / 2);
    touchPoint2 = ofVec2f(ofGetWidth() / 2,ofGetHeight() / 2);
    
    disp = true;
    disp2 = false;

}

//--------------------------------------------------------------
void ofApp::update(){
    
}

//--------------------------------------------------------------
void ofApp::draw(){
    if(disp){
        ofSetColor(0);
        ofDrawCircle( (touchPoint.x - ofGetWidth() / 2) * 1.1 + (ofGetWidth() / 2),
                     (touchPoint.y - ofGetHeight() / 2) * 1.2 +
                     ofGetHeight() / 2, 100);
        ofSetColor(255);
        ofDrawCircle(touchPoint, 100);
    }
    if(disp2){
        // touchpoint2
        ofSetColor(0);
        ofDrawCircle( (touchPoint2.x - ofGetWidth() / 2) * 1.1 + (ofGetWidth() / 2),
                     (touchPoint2.y - ofGetHeight() / 2) * 1.2 +
                     ofGetHeight() / 2, 100);
        ofSetColor(255);
        ofDrawCircle(touchPoint2, 100);
    }
}

//--------------------------------------------------------------
void ofApp::exit(){
    
}


//--------------------------------------------------------------
void ofApp::audioOut(float * output, int bufferSize, int nChannels) {
    
        
        for (int i = 0; i < bufferSize; i++){

            wave = samp.playOnce(touchPoint.x * 2 / ofGetWidth());
            wave2 = samp2.playOnce(touchPoint2.x * 2 / ofGetWidth());
            
            myFilteredOutput=myFilter.lores(wave, touchPoint.y * 2, 10);
            myFilteredOutput2=myFilter2.lores(wave2, touchPoint2.y * 2, 10);
            
            output[i*nChannels    ] = myFilteredOutput + myFilteredOutput2;
            output[i*nChannels + 1] = myFilteredOutput + myFilteredOutput2;
        }

	
}

//--------------------------------------------------------------
void ofApp::audioIn(float * input, int bufferSize, int nChannels){

}


//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs &touch){
    cout << touch.id << endl;
//    touchPoint.set(touch);
    if(touch.id == 0){
        disp = true;
        samp.setPosition(0); // play from beginning;
        touchPoint.set(touch);
    } else if (touch.id == 1){
        disp2 = true;
        samp2.setPosition(0); // play from beginning;
        touchPoint2.set(touch);
    }
    

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs &touch){
    if(touch.id == 0){
        touchPoint.set(touch);
    } else if (touch.id == 1){
        touchPoint2.set(touch);
    }
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs &touch){
    if(touch.id == 0){
        disp = false;
    } else if (touch.id == 1){
        disp2 = false;
    }
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs &touch){
    
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

