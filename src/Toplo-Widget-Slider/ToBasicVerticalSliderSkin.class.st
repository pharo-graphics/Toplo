Class {
	#name : #ToBasicVerticalSliderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Slider-Core'
}

{ #category : #initialization }
ToBasicVerticalSliderSkin >> initializeBarForElement: element [

	| sliderBar |
	sliderBar := element sliderBar.
	sliderBar id: #sliderBar.
	sliderBar background: Color veryLightGray.
	sliderBar vMatchParent.
	sliderBar width: 10.
	sliderBar constraintsDo: [ :c | c frame horizontal alignCenter ].
	sliderBar geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	sliderBar zIndex: 2
]

{ #category : #initialization }
ToBasicVerticalSliderSkin >> initializeKnobForElement: element [

	| sliderKnob pt |
	sliderKnob := element sliderKnob.
	sliderKnob id: #sliderKnob.
	sliderKnob zIndex: 4.
	pt := 20 @ 20.
	sliderKnob
		geometry: BlCircleGeometry new;
		background: Color lightRed;
		extent: pt;
		transformDo: [ :t | t translateBy: 0 @ (pt negated y / 2) ].
	sliderKnob whenLayoutedDoOnce: [
			sliderKnob constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTopAt: pt y / 2 / element height ] ]
]

{ #category : #'event handling' }
ToBasicVerticalSliderSkin >> installSkinEvent: anEvent [
	"Be careful, adding padding makes the knob imprecise"

	anEvent elementDo: [ :elt |
			elt extent: 50 @ 200.
			elt layout: BlFrameLayout new.
			elt clipChildren: false.
			self initializeBarForElement: elt.
			self initializeKnobForElement: elt ]
]
