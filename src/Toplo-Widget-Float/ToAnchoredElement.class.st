Class {
	#name : #ToAnchoredElement,
	#superclass : #ToElement,
	#instVars : [
		'innerElement',
		'offset',
		'placement'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToAnchoredElement >> applyConfiguration [ 

	placement configure: self
]

{ #category : #configuration }
ToAnchoredElement >> atBottom [

	self placement: ToAnchoredAtBottom new
]

{ #category : #configuration }
ToAnchoredElement >> atBottomLeft [

	self placement: ToAnchoredAtBottomLeft new
]

{ #category : #configuration }
ToAnchoredElement >> atBottomRight [

	self placement: ToAnchoredAtBottomRight new
]

{ #category : #configuration }
ToAnchoredElement >> atCenter [

	self placement: ToAnchoredAtCenter new
]

{ #category : #configuration }
ToAnchoredElement >> atLeft [

	self placement: ToAnchoredAtLeft new
]

{ #category : #configuration }
ToAnchoredElement >> atPerimeterAround: aPivotalElement atDegrees: anAngleInDegrees [

	self placement: (ToAnchoredAtPerimeter new
			 around: aPivotalElement atDegrees: anAngleInDegrees;
			 yourself)
]

{ #category : #configuration }
ToAnchoredElement >> atRight [

	self placement: ToAnchoredAtRight new
]

{ #category : #configuration }
ToAnchoredElement >> atTop [

	self placement: ToAnchoredAtTop new
]

{ #category : #configuration }
ToAnchoredElement >> atTopLeft [

	self placement: ToAnchoredAtTopLeft new
]

{ #category : #configuration }
ToAnchoredElement >> atTopRight [

	self placement: ToAnchoredAtTopRight new
]

{ #category : #accessing }
ToAnchoredElement >> builder: aValuable [

	aValuable value: innerElement
]

{ #category : #initialization }
ToAnchoredElement >> defaultElevation [

	" to be over context menu selection element "
	^ BlRelativeElevation elevation: 16
]

{ #category : #initialization }
ToAnchoredElement >> defaultOffset [

	^ 0 asPoint

]

{ #category : #initialization }
ToAnchoredElement >> defaultPlacement [ 

	^ ToAnchoredAtCenter new
]

{ #category : #initialization }
ToAnchoredElement >> initialize [ 

	super initialize.
	innerElement := ToElement new.
	innerElement fitContent.
	innerElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self addChild: innerElement.

	self focusability: BlFocusability none.
	self elevation: self defaultElevation.
	self fitContent.
	self constraintsDo: [ :c | c ignoreByLayout ].
	offset := self defaultOffset.
	placement := self defaultPlacement 

]

{ #category : #accessing }
ToAnchoredElement >> offset [

	^ offset ifNil: [ offset := 8 @ -8 ]
]

{ #category : #accessing }
ToAnchoredElement >> offset: aPoint [

	offset := aPoint.
	self requestConfiguration 
]

{ #category : #accessing }
ToAnchoredElement >> placement: aPlacement [

	placement := aPlacement.
	self requestConfiguration 
]
