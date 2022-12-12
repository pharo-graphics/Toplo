Class {
	#name : #ToImage,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToWidgetWithViewModel',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait',
	#instVars : [
		'#innerImage => ObservableSlot'
	],
	#category : #'Toplo-Widget-Image'
}

{ #category : #initialization }
ToImage >> defaultInnerImage [

	^ BlElement new
		  id: #emptyImage;
		  size: 0 @ 0;
		  yourself
]

{ #category : #testing }
ToImage >> hasInnerImage [

	^ self innerImage id asSymbol ~= #emptyImage
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

{ #category : #'api - change hook' }
ToImage >> whenInnerImageReplacedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #innerImage whenChangedDo: aBlock
]
