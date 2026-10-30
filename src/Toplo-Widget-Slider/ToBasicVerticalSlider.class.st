Class {
	#name : #ToBasicVerticalSlider,
	#superclass : #ToBasicSlider,
	#category : #'Toplo-Widget-Slider-Core'
}

{ #category : #examples }
ToBasicVerticalSlider class >> simpleExample [

	<script>
	| slider textElt space |
	slider := self new position: 50 asPoint.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.

	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider newValueCallback: [ :value |
		textElt text: value asRopedText ].
	space show
]

{ #category : #'api - transformations' }
ToBasicVerticalSlider >> moveKnobTo: aPosition [

	self height isZero ifTrue: [ ^ self ].
	self currentValue: (self valueAtCoord: (self placeKnobAt: aPosition))
]

{ #category : #'instance creation' }
ToBasicVerticalSlider >> newRawSkin [

	^ ToBasicVerticalSliderSkin new
]

{ #category : #'api - transformations' }
ToBasicVerticalSlider >> placeKnobAt: aPosition [
	"Place the knob center at aPosition, kept inside the slider, without changing the value. Answer the position actually used"

	| newPosY |
	newPosY := aPosition y clampBetween: sliderKnob height / 2 and: self height - (sliderKnob height / 2).
	sliderKnob constraintsDo: [ :c |
		c frame vertical alignment: (BlVerticalCoordinateTopAlignment new coordinate: newPosY / self height) ].
	^ aPosition x @ newPosY
]

{ #category : #'api - transformations' }
ToBasicVerticalSlider >> valueAtCoord: aPosition [

	| valueDiff value coeff posY |
	posY := aPosition y.
	posY = (sliderKnob height / 2) ifTrue: [ ^ maxValue ].
	posY = (self height - (sliderKnob height / 2)) ifTrue: [ ^ minValue ].
	valueDiff := maxValue - minValue.
	coeff := self height - sliderKnob height / (posY - (sliderKnob height / 2)).
	value := maxValue - (valueDiff / coeff).
	"No quantum (nil or zero) means no rounding"
	(self quantum isNil or: [ self quantum isZero ]) ifTrue: [ ^ value asFloat ].
	^ (value roundTo: self quantum) asFloat
]

{ #category : #'api - transformations' }
ToBasicVerticalSlider >> valueToCoord: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ 0 @ self height  - (sliderKnob height / 2
	   + (self height - sliderKnob height * coeff))
]
