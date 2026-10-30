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

	| sliderKnob pt layoutHandler |
	sliderKnob := element sliderKnob.
	sliderKnob id: #sliderKnob.
	sliderKnob zIndex: 4.
	pt := 20 @ 20.
	sliderKnob
		geometry: BlCircleGeometry new;
		background: Color lightRed;
		extent: pt;
		transformDo: [ :t | t translateBy: 0 @ (pt negated y / 2) ].
	"Wait for a layout giving the track a real height (it is 0 while the slider is gone)"
	layoutHandler := sliderKnob addEventHandlerOn: BlElementLayoutComputedEvent do: [
			                 element track height isZero ifFalse: [
					                 sliderKnob removeEventHandler: layoutHandler.
					                 sliderKnob constraintsDo: [ :c | c frame horizontal alignCenter ].
					                 element placeKnobAtCurrentValue ] ]
]

{ #category : #'event handling' }
ToBasicVerticalSliderSkin >> installSkinEvent: anEvent [
	"Be careful, adding padding makes the knob imprecise"

	anEvent elementDo: [ :elt |
			elt extent: 50 @ 200.
			elt updateLayout.
			elt clipChildren: false.
			self initializeBarForElement: elt.
			self initializeKnobForElement: elt ]
]
