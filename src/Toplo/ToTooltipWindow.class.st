Class {
	#name : 'ToTooltipWindow',
	#superclass : 'ToAnchoredWindow',
	#instVars : [
		'content'
	],
	#category : 'Toplo-Core-Tooltip',
	#package : 'Toplo',
	#tag : 'Core-Tooltip'
}

{ #category : 'api - displaying' }
ToTooltipWindow >> close [ 
	
	self content removeFromParent.
	super close
]

{ #category : 'accessing' }
ToTooltipWindow >> content [

	^ content
]

{ #category : 'accessing' }
ToTooltipWindow >> content: anElement [

	content ifNotNil: [ content removeFromParent ].
	content := anElement.
	anElement ifNotNil: [
		self root addChild: self content.
		self content constraintsDo: [ :c |
			c linear vertical alignCenter.
			c linear horizontal alignCenter.
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ]
]

{ #category : 'accessing' }
ToTooltipWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 300)
]

{ #category : 'initialization' }
ToTooltipWindow >> defaultEventHandler [ 
	
	^ self defaultEventHandlerClass new
]

{ #category : 'initialization' }
ToTooltipWindow >> defaultEventHandlerClass [

	^ ToTooltipWindowEventHandler

]

{ #category : 'initialization' }
ToTooltipWindow >> initialize [

	super initialize.
	self fitContent.
	self addEventHandler: self defaultEventHandler 
]

{ #category : 'skin' }
ToTooltipWindow >> installRawStyle [

	super installRawStyle.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	self border: (BlBorder paint: (Color gray alpha: 0.4)).
	self background: (Color yellow alpha: 0.2).
	self padding: (BlInsets all: 4)
]
