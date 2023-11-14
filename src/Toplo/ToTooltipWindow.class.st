Class {
	#name : #ToTooltipWindow,
	#superclass : #ToAnchoredWindow,
	#category : 'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipWindow >> close [

	self root removeChildren.
	^super close
]

{ #category : #accessing }
ToTooltipWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : #initialization }
ToTooltipWindow >> defaultEventHandler [ 
	
	^ self defaultEventHandlerClass new
]

{ #category : #initialization }
ToTooltipWindow >> defaultEventHandlerClass [

	^ ToTooltipWindowEventHandler

]

{ #category : #initialization }
ToTooltipWindow >> initialize [

	super initialize.
	self fitContent.
	self addEventHandler: self defaultEventHandler 
]

{ #category : #skin }
ToTooltipWindow >> installRawStyle [

	super installRawStyle.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	self border: (BlBorder paint: (Color gray alpha: 0.4)).
	self background: Color yellow.
	self padding: (BlInsets all: 4)
]
