Class {
	#name : 'ToAnchoredWindow',
	#superclass : 'ToAbstractWindowElement',
	#instVars : [
		'popupTimestamp',
		'windowHandler'
	],
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'accessing' }
ToAnchoredWindow >> applyPositionHookFromEvent: anEvent [

	^ windowHandler applyPositionHookFromEvent: anEvent
]

{ #category : 'accessing' }
ToAnchoredWindow >> applySizeHookFromEvent: anEvent [

	windowHandler applySizeHookFromEvent: anEvent
]

{ #category : 'api - displaying' }
ToAnchoredWindow >> checkBeforePopupEvent: anEvent [

	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]

{ #category : 'api - displaying' }
ToAnchoredWindow >> close [

	self parentDo: [ :p | super close ].
	self root removeChildren.
	self dispatchClosedEvent
]

{ #category : 'accessing' }
ToAnchoredWindow >> closedEventClass [

	^ ToWindowClosedEvent 
]

{ #category : 'accessing' }
ToAnchoredWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : 'api - displaying' }
ToAnchoredWindow >> dispatchClosedEvent [

	| event |
	event := self closedEventClass new.
	self element ifNotNil: [ :w | w dispatchEvent: event ].
	self dispatchEvent: event copy.

]

{ #category : 'api - displaying' }
ToAnchoredWindow >> dispatchOpenedEvent: anEvent [

	| event |
	event := self openedEventClass new
		         sourceEvent: anEvent;
		         yourself.
	self dispatchEvent: event.
	self element ifNotNil: [ :w | w dispatchEvent: event copy ]
]

{ #category : 'accessing' }
ToAnchoredWindow >> element [

	^ windowHandler ifNotNil: [:h | h element]
]

{ #category : 'accessing' }
ToAnchoredWindow >> handler: aWindowHandler [

	windowHandler := aWindowHandler 
]

{ #category : 'start' }
ToAnchoredWindow >> hasAssociateElement [

	^ self element notNil
]

{ #category : 'initialization' }
ToAnchoredWindow >> initialize [

	super initialize.
	self fitContent
]

{ #category : 'accessing' }
ToAnchoredWindow >> openedEventClass [

	^ ToWindowOpenedEvent 
]

{ #category : 'api - displaying' }
ToAnchoredWindow >> popup [
	
	self popupEvent: nil
]

{ #category : 'api - displaying' }
ToAnchoredWindow >> popupEvent: anEvent [
	" I have to set the position here "

	self element ifNil: [
		Error signal: 'Can''t popup an anchored window without associate element' ].
	self element isAttachedToSceneGraph ifFalse: [
		Error signal: 'Can''t popup an anchored window if the element is not attached to a space' ].
	self visibility: BlVisibility hidden. 
	self element space root addChild: self.
	self checkBeforePopupEvent: anEvent.
	self requestLayout.
	self whenLayoutedDoOnce: [
		" I need to finalize my position as soon as my layout is up-to-date "
		self toFront.
		self visibility: BlVisibility visible. 
		self dispatchOpenedEvent: anEvent.
		popupTimestamp := DateAndTime now ]
]

{ #category : 'accessing' }
ToAnchoredWindow >> popupTimestamp [

	^ popupTimestamp 
]
