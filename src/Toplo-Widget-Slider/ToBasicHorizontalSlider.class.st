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

{ #category : #'private - building' }
ToBasicHorizontalSlider >> layoutWithLabel [
	"Label left of the track. The fixed width moves to the track and the slider fits its content, so the label widens the slider instead of shrinking the track"

	self layout: BlLinearLayout horizontal.
	label margin: (BlInsets right: 10).
	label constraintsDo: [ :c | c linear vertical alignCenter ].
	self constraints horizontal resizer isExact ifTrue: [
			track width: self constraints horizontal resizer size.
			self hFitContent ]
]

{ #category : #'private - building' }
ToBasicHorizontalSlider >> layoutWithoutLabel [
	"Give the track width back to the slider"

	self layout: BlFrameLayout new.
	track constraints horizontal resizer isExact ifTrue: [
			self width: track constraints horizontal resizer size.
			track hMatchParent ]
]

{ #category : #'api - transformations' }
ToBasicHorizontalSlider >> moveKnobTo: aPosition [

	track width isZero ifTrue: [ ^ self ].
	self currentValue: (self valueAtCoord: (self placeKnobAt: aPosition))
]

{ #category : #'instance creation' }
ToBasicHorizontalSlider >> newRawSkin [

	^ ToBasicHorizontalSliderSkin new
]

{ #category : #'api - transformations' }
ToBasicHorizontalSlider >> placeKnobAt: aPosition [
	"Place the knob center at aPosition, kept inside the track, without changing the value. Answer the position actually used"

	| newPosX |
	newPosX := aPosition x clampBetween: sliderKnob width / 2 and: track width - (sliderKnob width / 2).
	sliderKnob constraintsDo: [ :c | c frame horizontal alignLeftAt: newPosX / track width ].
	^ newPosX @ aPosition y
]

{ #category : #'api - transformations' }
ToBasicHorizontalSlider >> valueAtCoord: aPosition [

	| valueDiff value coeff posX |
	posX := aPosition x.
	posX = (sliderKnob width / 2) ifTrue: [ ^ minValue ].
	valueDiff := maxValue - minValue.
	coeff := track width - sliderKnob width / (posX - (sliderKnob width / 2)).
	value := minValue + (valueDiff / coeff).
	"No quantum (nil or zero) means no rounding"
	(self quantum isNil or: [ self quantum isZero ]) ifTrue: [ ^ value asFloat ].
	^ (value roundTo: self quantum) asFloat
]

{ #category : #'api - transformations' }
ToBasicHorizontalSlider >> valueToCoord: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ sliderKnob width / 2 + (track width - sliderKnob width * coeff) @ 0
]
