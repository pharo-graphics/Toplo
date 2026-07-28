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

	| newPos newPosY |
	newPos := aPosition.
	newPosY := newPos y
		           clampBetween: sliderKnob height / 2
		           and: self height - (sliderKnob height / 2).
	newPos := newPos x @ newPosY.

	sliderKnob constraintsDo: [ :c |
			c frame vertical alignment:
				(BlVerticalCoordinateTopAlignment new coordinate:
					 newPosY / self height) ].

	self currentValue: (self valueAtCoord: newPos)
]

{ #category : #'instance creation' }
ToBasicVerticalSlider >> newRawSkin [

	^ ToBasicVerticalSliderSkin new
]

{ #category : #'api - transformations' }
ToBasicVerticalSlider >> valueAtCoord: aPosition [

	| valueDiff value coeff posY |
	posY := aPosition y.
	posY = (sliderKnob height / 2) ifTrue: [ ^ maxValue ].
	posY = (self height - (sliderKnob height / 2)) ifTrue: [ ^ minValue ].
	valueDiff := maxValue - minValue.
	coeff :=
	         (self height - sliderKnob height
	          / (posY - (sliderKnob height / 2))).
	value := maxValue - (valueDiff / coeff).

	^ (value roundTo: 1) asFloat
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
