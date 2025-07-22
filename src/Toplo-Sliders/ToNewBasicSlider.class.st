Class {
	#name : #ToNewBasicSlider,
	#superclass : #ToElement,
	#instVars : [
		'minValue',
		'maxValue',
		'currentValue',
		'sliderBar',
		'sliderKnob',
		'newValueCallback'
	],
	#category : #'Toplo-Sliders-Core'
}

{ #category : #'as yet unclassified' }
ToNewBasicSlider class >> simpleExample [

	<script>
	| slider textElt space |
	slider := ToNewBasicSlider new
		          position: 50 asPoint.

	textElt := BlTextElement new
		           position: 150 @ 100;
		           text: 0.0 asRopedText.

	space := BlSpace new.
	space root addChildren: {
			slider.
			textElt }.

	slider validatedValueCallback: [ :value |
		textElt text: value asRopedText ].
	space show
]

{ #category : #private }
ToNewBasicSlider >> currentValue [

	^ currentValue
]

{ #category : #private }
ToNewBasicSlider >> currentValue: aNumber [

	currentValue := aNumber.
	self newValueCallback ifNotNil: [ :e | e value: currentValue ]
]

{ #category : #initialization }
ToNewBasicSlider >> initialize [

	super initialize.
	self initializeDefaultValues.
	self initializeEvents.
	self initializeBar.
	self initializeKnob
]

{ #category : #'private - building' }
ToNewBasicSlider >> initializeBar [

	sliderBar := ToElement new.
	self addChild: sliderBar
]

{ #category : #accessing }
ToNewBasicSlider >> initializeDefaultValues [

	maxValue := 100.0.
	minValue := 0.0.
	currentValue := 0.0.
]

{ #category : #initialization }
ToNewBasicSlider >> initializeEvents [

	self
		addEventHandlerOn: BlMouseDownEvent
		do: [ :event |
		self moveKnobTo: (self globalPointToLocal: event position) ].
	self
		addEventHandlerOn: BlDragStartEvent
		do: [ :event | event consume ].
	self
		addEventHandlerOn: BlDragEvent
		do: [ :event |
		self moveKnobTo: (self globalPointToLocal: event position) ]
]

{ #category : #'private - building' }
ToNewBasicSlider >> initializeKnob [

	sliderKnob := ToElement new.
	self addChild: sliderKnob
]

{ #category : #'api - values' }
ToNewBasicSlider >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
ToNewBasicSlider >> maxValue: anObject [

	maxValue := anObject
]

{ #category : #'api - values' }
ToNewBasicSlider >> minValue [

	^ minValue
]

{ #category : #'api - values' }
ToNewBasicSlider >> minValue: aNumber [

	minValue := aNumber.
]

{ #category : #'api - transformations' }
ToNewBasicSlider >> moveKnobTo: aPosition [

	self subclassResponsibility 
]

{ #category : #'instance creation' }
ToNewBasicSlider >> newRawSkin [ 

	self subclassResponsibility 
]

{ #category : #private }
ToNewBasicSlider >> newValueCallback [

	^ newValueCallback
]

{ #category : #'api - values' }
ToNewBasicSlider >> newValueCallback: anObject [

	newValueCallback := anObject
]

{ #category : #'api - slider' }
ToNewBasicSlider >> setToMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
ToNewBasicSlider >> setToMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
ToNewBasicSlider >> setValue: aValue [

	self moveKnobTo: (self valueToCoord: aValue).
]

{ #category : #accessing }
ToNewBasicSlider >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
ToNewBasicSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #accessing }
ToNewBasicSlider >> sliderKnob [

	^ sliderKnob
]

{ #category : #accessing }
ToNewBasicSlider >> sliderKnob: anObject [

	sliderKnob := anObject
]

{ #category : #'api - transformations' }
ToNewBasicSlider >> valueAtCoord: aPosition [

	self subclassResponsibility 
]

{ #category : #'api - transformations' }
ToNewBasicSlider >> valueToCoord: aValue [

	self subclassResponsibility 
]
