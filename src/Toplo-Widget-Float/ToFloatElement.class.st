Class {
	#name : #ToFloatElement,
	#superclass : #ToElement,
	#instVars : [
		'innerElement',
		'offset'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #configuration }
ToFloatElement >> atBottom [

	self constraintsDo: [ :c |
			c anchors removeAll.
			c anchors addAll: {
					(c anchors bottomAnchor on:
						 c anchors parent bottomAnchor + self offset y).
					(c anchors horizontalCenterAnchor on:
						 c anchors parent horizontalCenterAnchor + self offset x) } ]
]

{ #category : #configuration }
ToFloatElement >> atBottomLeft [

	self constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors bottomLeftAnchor on:
					 c anchors parent bottomLeftAnchor + self offset) ]
]

{ #category : #configuration }
ToFloatElement >> atBottomRight [

	self constraintsDo: [ :c |
			c anchors add: (c anchors bottomRightAnchor on:
					 c anchors parent bottomRightAnchor + self offset) ]
]

{ #category : #configuration }
ToFloatElement >> atLeft [

	self constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors leftAnchor on:
					 c anchors parent leftAnchor + self offset x).
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor + self offset y) ]
]

{ #category : #configuration }
ToFloatElement >> atRight [

	self constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors rightAnchor on:
					 c anchors parent rightAnchor + self offset x).
			c anchors add: (c anchors verticalCenterAnchor on:
					 c anchors parent verticalCenterAnchor + self offset y) ]
]

{ #category : #configuration }
ToFloatElement >> atTop [

	self constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add:
				(c anchors topAnchor on:
					 c anchors parent topAnchor + self offset y).
			c anchors add: (c anchors horizontalCenterAnchor on:
					 c anchors parent horizontalCenterAnchor + self offset x) ]
]

{ #category : #configuration }
ToFloatElement >> atTopLeft [

	self constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors topLeftAnchor on:
					 c anchors parent topLeftAnchor + self offset) ]
]

{ #category : #configuration }
ToFloatElement >> atTopRight [

	self constraintsDo: [ :c |
			c anchors removeAll.
			c anchors add: (c anchors topRightAnchor on:
					 c anchors parent topRightAnchor + self offset) ]
]

{ #category : #accessing }
ToFloatElement >> builder: aValuable [

	aValuable value: innerElement
]

{ #category : #initialization }
ToFloatElement >> defaultElevation [

	" to be over context menu selection element "
	^ BlRelativeElevation elevation: 16
]

{ #category : #initialization }
ToFloatElement >> defaultOffset [

	^ 0 asPoint

]

{ #category : #initialization }
ToFloatElement >> initialize [ 

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
	offset := self defaultOffset.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self atBottomRight

]

{ #category : #skin }
ToFloatElement >> installRawStyle [

	super installRawStyle.
	self background: (self valueOfTokenNamed: #'background-color').
	self effect:
		(BlGaussianShadowEffect color: Color gray width: 8 offset: 1 @ 1)
]

{ #category : #accessing }
ToFloatElement >> offset [

	^ offset ifNil: [ offset := 8 @ -8 ]
]

{ #category : #accessing }
ToFloatElement >> offset: aPoint [

	offset := aPoint.
	self requestConfiguration 
]
