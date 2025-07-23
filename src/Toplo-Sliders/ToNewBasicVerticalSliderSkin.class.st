Class {
	#name : #ToNewBasicVerticalSliderSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Sliders-Core'
}

{ #category : #initialization }
ToNewBasicVerticalSliderSkin >> initializeBarForElement: element [

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
ToNewBasicVerticalSliderSkin >> initializeKnobForElement: element [

	| sliderKnob pt |
	sliderKnob := element sliderKnob.
	sliderKnob id: #sliderKnob.
	sliderKnob zIndex: 3.
	pt := 20 @ 20.
	sliderKnob
		geometry: BlCircleGeometry new;
		background: Color lightRed;
		size: pt;
		transformDo: [ :t | t translateBy: 0 @ (pt negated y / 2) ].
	sliderKnob whenLayoutedDoOnce: [
			sliderKnob constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignTopAt: pt y / 2 / element height ] ]
]

{ #category : #'event handling' }
ToNewBasicVerticalSliderSkin >> installSkinEvent: anEvent [

	anEvent elementDo: [ :elt |
			elt size: 50 @ 200.
			elt layout: BlFrameLayout new.
			elt clipChildren: false.
			elt padding: (BlInsets all: 5).
			self initializeBarForElement: elt.
			self initializeKnobForElement: elt ]
]
