Class {
	#name : #ToBasicHorizontalSliderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Slider-Core'
}

{ #category : #initialization }
ToBasicHorizontalSliderSkin >> initializeBarForElement: element [ 

	
	| sliderBar |
	sliderBar := element sliderBar.
	sliderBar id: #sliderBar.
	sliderBar background: Color veryLightGray.
	sliderBar hMatchParent.
	sliderBar height: 10.
	sliderBar constraintsDo: [ :c | c frame vertical alignCenter ].
	sliderBar geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	sliderBar zIndex: 2.
]

{ #category : #initialization }
ToBasicHorizontalSliderSkin >> initializeKnobForElement: element [

	| sliderKnob pt |
	sliderKnob := element sliderKnob.
	sliderKnob id: #sliderKnob.
	sliderKnob zIndex: 4.
	pt := 20 @ 20.
	sliderKnob
		geometry: BlCircleGeometry new;
		background: Color lightRed;
		extent: pt;
		transformDo: [ :t | t translateBy: pt negated x / 2 @ 0 ].
	sliderKnob whenLayoutedDoOnce: [
			sliderKnob constraintsDo: [ :c |
					c frame vertical alignCenter.
					c frame horizontal alignLeftAt: pt x / 2 / element width ] ]
]

{ #category : #'event handling' }
ToBasicHorizontalSliderSkin >> installSkinEvent: anEvent [
	"Be careful, adding padding makes the knob imprecise"

	anEvent elementDo: [ :elt |
			elt extent: 200 @ 50.
			elt layout: BlFrameLayout new.
			elt clipChildren: false.
			self initializeBarForElement: elt.
			self initializeKnobForElement: elt ]
]
