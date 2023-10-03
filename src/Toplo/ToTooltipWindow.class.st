Class {
	#name : #ToTooltipWindow,
	#superclass : #ToPopupWindow,
	#instVars : [
		'content'
	],
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #accessing }
ToTooltipWindow >> content [

	^ content
]

{ #category : #accessing }
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

{ #category : #initialization }
ToTooltipWindow >> defaulPositionHook [

	^ [ :w :event | event position x @ (w widget localPointToGlobal: 0 @ w widget height) y + self vgap ]
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
ToTooltipWindow >> defaultWidgetEventHandler [ 

	^ self defaultWidgetEventHandlerClass new
]

{ #category : #initialization }
ToTooltipWindow >> defaultWidgetEventHandlerClass [

	^ ToWidgetWithTooltipEventHandler
]

{ #category : #initialization }
ToTooltipWindow >> detachFromWidget [

	super detachFromWidget.
	self content: nil
]

{ #category : #initialization }
ToTooltipWindow >> initialize [

	super initialize.
	self elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
	self border: (BlBorder paint: (Color gray alpha: 0.4)).
	self background: (Color yellow alpha: 0.2).
	self padding: (BlInsets all: 4).
	self fitContent.
	self addEventHandler: self defaultEventHandler
]

{ #category : #initialization }
ToTooltipWindow >> vgap [

	^ 5
]
