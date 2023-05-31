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

{ #category : #'instance creation' }
ToImage class >> inner: anImage [

	^ self new innerImage: anImage
]

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

	super initialize.
	
	self fitContent.
	self innerImage: self defaultInnerImage.
	
	" I ** must be ** considered as a leaf of a UI element tree. Otherwise, click may not work on me. This is why my children are not allowed to manage mouse events. Related to https://github.com/plantec/Toplo/issues/41"
	self preventChildrenMouseEvents.
]

{ #category : #accessing }
ToImage >> innerImage [

	^ innerImage 
]

{ #category : #accessing }
ToImage >> innerImage: anImage [

	| element |
	anImage = innerImage ifTrue: [ ^ self ].
	element := anImage
		           ifNil: [ self defaultInnerImage ]
		           ifNotNil: [ anImage asElement ].
	innerImage
		ifNil: [ self addChild: element ]
		ifNotNil: [ self replaceChild: innerImage with: element ].
	innerImage := element
]

{ #category : #'api - change hook' }
ToImage >> whenInnerImageReplacedDo: aBlock [

	"set a block to perform after that the image has been changed, and its action performed"

	self property: #innerImage whenChangedDo: aBlock
]
