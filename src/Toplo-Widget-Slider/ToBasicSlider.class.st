"
This class represents a slider.

This slider aims to be the foundation of a new slider for Toplo, its design is simple and its API aims to gather the basic behaviors of a slider.

This slider was influenced by the `ToDesignSlider` and the `ToOldBasicSlider`.
"
Class {
	#name : #ToBasicSlider,
	#superclass : #ToElement,
	#instVars : [
		'minValue',
		'maxValue',
		'currentValue',
		'sliderBar',
		'sliderKnob',
		'newValueCallback'
	],
	#category : #'Toplo-Widget-Slider-Core'
}

{ #category : #private }
ToBasicSlider >> currentValue [

	^ currentValue
]

{ #category : #private }
ToBasicSlider >> currentValue: aNumber [

	currentValue := aNumber.
	self newValueCallback ifNotNil: [ :e | e value: currentValue ]
]

{ #category : #initialization }
ToBasicSlider >> initialize [

	super initialize.
	self initializeDefaultValues.
	self initializeEvents.
	self initializeBar.
	self initializeKnob
]

{ #category : #'private - building' }
ToBasicSlider >> initializeBar [

	sliderBar := ToElement new.
	self addChild: sliderBar
]

{ #category : #accessing }
ToBasicSlider >> initializeDefaultValues [

	maxValue := 100.0.
	minValue := 0.0.
	currentValue := 0.0.
]

{ #category : #initialization }
ToBasicSlider >> initializeEvents [

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
ToBasicSlider >> initializeKnob [

	sliderKnob := ToElement new.
	self addChild: sliderKnob
]

{ #category : #'api - values' }
ToBasicSlider >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
ToBasicSlider >> maxValue: anObject [

	maxValue := anObject
]

{ #category : #'api - values' }
ToBasicSlider >> minValue [

	^ minValue
]

{ #category : #'api - values' }
ToBasicSlider >> minValue: aNumber [

	minValue := aNumber.
]

{ #category : #'api - transformations' }
ToBasicSlider >> moveKnobTo: aPosition [

	self subclassResponsibility 
]

{ #category : #'instance creation' }
ToBasicSlider >> newRawSkin [ 

	self subclassResponsibility 
]

{ #category : #private }
ToBasicSlider >> newValueCallback [

	^ newValueCallback
]

{ #category : #'api - values' }
ToBasicSlider >> newValueCallback: anObject [

	newValueCallback := anObject
]

{ #category : #'api - slider' }
ToBasicSlider >> setToMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
ToBasicSlider >> setToMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
ToBasicSlider >> setValue: aValue [

	self moveKnobTo: (self valueToCoord: aValue).
]

{ #category : #accessing }
ToBasicSlider >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
ToBasicSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #accessing }
ToBasicSlider >> sliderKnob [

	^ sliderKnob
]

{ #category : #accessing }
ToBasicSlider >> sliderKnob: anObject [

	sliderKnob := anObject
]

{ #category : #'api - transformations' }
ToBasicSlider >> valueAtCoord: aPosition [

	self subclassResponsibility 
]

{ #category : #'api - transformations' }
ToBasicSlider >> valueToCoord: aValue [

	self subclassResponsibility 
]
