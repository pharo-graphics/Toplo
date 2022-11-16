Class {
	#name : #ToImage,
	#superclass : #ToWidget,
	#traits : 'TBlAlignable + TOBlLayoutResizable',
	#classTraits : 'TBlAlignable classTrait + TOBlLayoutResizable classTrait',
	#instVars : [
		'#innerImage => ObservableSlot'
	],
	#category : #'Toplo-Widget-Images'
}

{ #category : #initialization }
ToImage >> defaultInnerImage [

	^ BlElement new size: 0 @ 0
]

{ #category : #initialization }
ToImage >> defaultViewModel [

	^ ToImageModel new.

]

{ #category : #accessing }
ToImage >> horizontalAlignment [
	<return: #BlElementAlignment>

	^ self layout horizontalAlignment 
]

{ #category : #accessing }
ToImage >> horizontalAlignment: aBlElementAlignment [

	self horizontalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout horizontalAlignment: aBlElementAlignment.

]

{ #category : #initialization }
ToImage >> initialize [
	
	self class initializeSlots: self.
	super initialize.
	self fitContent.
	self innerImage: self defaultInnerImage 
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

{ #category : #accessing }
ToImage >> verticalAlignment [
	<return: #BlElementAlignment>
	
	^ self layout verticalAlignment 
]

{ #category : #accessing }
ToImage >> verticalAlignment: aBlElementAlignment [

	self verticalAlignment = aBlElementAlignment ifTrue: [ ^self ].
	self layout verticalAlignment: aBlElementAlignment

]

{ #category : #'api - change hook' }
ToImage >> whenInnerImageReplacedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #innerImage whenChangedDo: aBlock
]
