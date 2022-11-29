Class {
	#name : #ToImage,
	#superclass : #BlElement,
	#traits : 'TToWidget',
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'#innerImage => ObservableSlot'
	],
	#category : #'Toplo-Widget-Image'
}

{ #category : #initialization }
ToImage >> defaultInnerImage [

	^ BlElement new size: 0 @ 0; yourself
]

{ #category : #initialization }
ToImage >> defaultViewModel [

	^ ToImageModel new.

]

{ #category : #initialization }
ToImage >> initialize [

	self class initializeSlots: self.
	super initialize.
	self constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent ].
	self innerImage: self defaultInnerImage.
	self dresser: self defaultDresser
]

{ #category : #accessing }
ToImage >> innerImage [

	^ innerImage 
]

{ #category : #accessing }
ToImage >> innerImage: anImage [

	| element |
	anImage = innerImage ifTrue: [ ^ self ].
	self removeChildren.
	element := anImage ifNil: [ self defaultInnerImage ] ifNotNil: [anImage asElement].
	self addChild: element.
	innerImage := element
]

{ #category : #'api - change hook' }
ToImage >> whenInnerImageReplacedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #innerImage whenChangedDo: aBlock
]
