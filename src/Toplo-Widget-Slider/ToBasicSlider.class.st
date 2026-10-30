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
		'newValueCallback',
		'quantum',
		'track',
		'label'
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

{ #category : #testing }
ToBasicSlider >> hasLabel [

	^ label notNil
]

{ #category : #initialization }
ToBasicSlider >> initialize [

	super initialize.
	self initializeDefaultValues.
	self initializeEvents.
	self initializeTrack.
	self initializeBar.
	self initializeKnob
]

{ #category : #'private - building' }
ToBasicSlider >> initializeBar [

	sliderBar := ToElement new.
	track addChild: sliderBar
]

{ #category : #accessing }
ToBasicSlider >> initializeDefaultValues [

	maxValue := 100.0.
	minValue := 0.0.
	currentValue := 0.0.
	quantum := 1
]

{ #category : #initialization }
ToBasicSlider >> initializeEvents [

	self addEventHandlerOn: BlMouseDownEvent do: [ :event |
			| position |
			position := track globalPointToLocal: event position.
			(self isOutsideTrack: position) ifFalse: [ self moveKnobTo: position ] ].
	"Not consuming the drag start (e.g. on the label) means no drag events follow"
	self
		addEventHandlerOn: BlDragStartEvent
		do: [ :event | (self isOutsideTrack: (track globalPointToLocal: event position)) ifFalse: [ event consume ] ].
	self addEventHandlerOn: BlDragEvent do: [ :event | self moveKnobTo: (track globalPointToLocal: event position) ]
]

{ #category : #'private - building' }
ToBasicSlider >> initializeKnob [

	sliderKnob := ToElement new.
	track addChild: sliderKnob
]

{ #category : #'private - building' }
ToBasicSlider >> initializeTrack [

	track := ToElement new.
	track layout: BlFrameLayout new.
	track clipChildren: false.
	track constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	self addChild: track
]

{ #category : #private }
ToBasicSlider >> isOutsideTrack: aTrackLocalPoint [
	"Only possible with a label: a click on the label must not change the value"

	self hasLabel ifFalse: [ ^ false ].
	^ (aTrackLocalPoint x between: 0 and: track width) not or: [ (aTrackLocalPoint y between: 0 and: track height) not ]
]

{ #category : #accessing }
ToBasicSlider >> label [
	"The ToLabel shown before the track, or nil"

	^ label
]

{ #category : #accessing }
ToBasicSlider >> labelText [

	self hasLabel ifFalse: [ ^ nil ].
	^ self label text asString
]

{ #category : #accessing }
ToBasicSlider >> labelText: aString [
	"Show aString before the track. nil or an empty string removes the label"

	label ifNotNil: [ label removeFromParent ].
	label := nil.
	(aString isNil or: [ aString isEmpty ]) ifFalse: [
			label := ToLabel text: aString asRopedText.
			self addChildFirst: label ].
	self updateLayout
]

{ #category : #'private - building' }
ToBasicSlider >> layoutWithLabel [
	"Put the label before the track, the track keeping the slider main-axis size"

	self subclassResponsibility
]

{ #category : #'private - building' }
ToBasicSlider >> layoutWithoutLabel [
	"Restore the frame layout where the track matches the slider"

	self subclassResponsibility
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

{ #category : #'api - transformations' }
ToBasicSlider >> placeKnobAt: aPosition [
	"Place the knob center at aPosition without changing the value. Answer the position actually used"

	self subclassResponsibility
]

{ #category : #'api - transformations' }
ToBasicSlider >> placeKnobAtCurrentValue [
	"Place the knob for the current value without notifying the value callback (e.g. once the slider gets a size)"

	(track width isZero or: [ track height isZero ]) ifTrue: [ ^ self ].
	self placeKnobAt: (self valueToCoord: self currentValue)
]

{ #category : #accessing }
ToBasicSlider >> quantum [

	^ quantum
]

{ #category : #accessing }
ToBasicSlider >> quantum: anObject [

	quantum := anObject
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
	"Keep the value even when the slider has no size yet: the knob cannot be placed then."

	currentValue := aValue.
	self moveKnobTo: (self valueToCoord: aValue)
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

{ #category : #accessing }
ToBasicSlider >> track [
	"Holds the bar and the knob; value<->coordinate maths are relative to it"

	^ track
]

{ #category : #'private - building' }
ToBasicSlider >> updateLayout [
	"Without a label the track alone fills the slider. Called by the skin and when the label changes"

	self hasLabel
		ifTrue: [ self layoutWithLabel ]
		ifFalse: [ self layoutWithoutLabel ]
]

{ #category : #'api - transformations' }
ToBasicSlider >> valueAtCoord: aPosition [

	self subclassResponsibility 
]

{ #category : #'api - transformations' }
ToBasicSlider >> valueToCoord: aValue [

	self subclassResponsibility 
]
