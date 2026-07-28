Class {
	#name : #ToBasicHorizontalSlider,
	#superclass : #ToBasicSlider,
	#category : #'Toplo-Widget-Slider-Core'
}

{ #category : #examples }
ToBasicHorizontalSlider class >> simpleExample [

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

	slider newValueCallback: [ :value | textElt text: value asRopedText ].
	space show
]

{ #category : #'api - transformations' }
ToBasicHorizontalSlider >> moveKnobTo: aPosition [

	| newPos newPosX |
	newPos := aPosition.
	newPosX := newPos x
		           clampBetween: sliderKnob width / 2
		           and: self width - (sliderKnob width / 2).
	newPos := newPosX @ newPos y.

	sliderKnob constraintsDo: [ :c |
		c frame horizontal alignLeftAt: newPosX / self width ].

	self currentValue: (self valueAtCoord: newPos)
]

{ #category : #'instance creation' }
ToBasicHorizontalSlider >> newRawSkin [

	^ ToBasicHorizontalSliderSkin new
]

{ #category : #'api - transformations' }
ToBasicHorizontalSlider >> valueAtCoord: aPosition [

	| valueDiff value coeff posX |
	posX := aPosition x.
	posX = (sliderKnob width / 2) ifTrue: [ ^ minValue ].
	valueDiff := maxValue - minValue.
	coeff := self width - sliderKnob width
	         / (posX - (sliderKnob width / 2)).
	value := minValue + (valueDiff / coeff).

	^ (value roundTo: 1) asFloat
]

{ #category : #'api - transformations' }
ToBasicHorizontalSlider >> valueToCoord: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ sliderKnob width / 2
	  + (self width - sliderKnob width * coeff) @ 0
]
