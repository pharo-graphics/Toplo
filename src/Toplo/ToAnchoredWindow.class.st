Class {
	#name : 'ToAnchoredWindow',
	#superclass : 'ToBasicWindowElement',
	#instVars : [
		'popupTimestamp',
		'windowManager'
	],
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'accessing' }
ToAnchoredWindow >> applyPositionHookFromEvent: anEvent [

	windowManager applyPositionHookFromEvent: anEvent
]

{ #category : 'accessing' }
ToAnchoredWindow >> applySizeHookFromEvent: anEvent [

	windowManager applySizeHookFromEvent: anEvent
]

{ #category : 'api - displaying' }
ToAnchoredWindow >> checkBeforePopupEvent: anEvent [

	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]

{ #category : 'api - displaying' }
ToAnchoredWindow >> close [

	super close.
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
	self element dispatchEvent: event copy.
	self dispatchEvent: event.

]

{ #category : 'api - displaying' }
ToAnchoredWindow >> dispatchOpenedEvent: anEvent [

	| event |
	event := self openedEventClass new
		         sourceEvent: anEvent;
		         yourself.
	self dispatchEvent: event.
	self element dispatchEvent: event copy
]

{ #category : 'accessing' }
ToAnchoredWindow >> element [

	^ self manager ifNotNil: [:h | h element]
]

{ #category : 'testing' }
ToAnchoredWindow >> hasAssociateElement [

	^ self element notNil
]

{ #category : 'skin' }
ToAnchoredWindow >> installRawStyle [

	super installRawStyle.
	self background: (self tokenValueNamed: #'color-bg-container').
	(self tokenValueNamed: #'animation-window-opening') value: self.
	self effect: (self tokenValueNamed: #'effect-window').
	self padding: (BlInsets
			 horizontal: (self tokenValueNamed: #'padding-content-H')
			 vertical: (self tokenValueNamed: #'padding-content-V'))
]

{ #category : 'accessing' }
ToAnchoredWindow >> manager [

	^ windowManager 
]

{ #category : 'accessing' }
ToAnchoredWindow >> manager: aWindowHandler [

	windowManager := aWindowHandler 
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

	self manager ifNil: [
		Error signal: 'Can''t popup an anchored window without window manager' ].
	self hasAssociateElement ifFalse: [
		Error signal: 'Can''t popup an anchored window without associate element' ].
	self element isAttachedToSceneGraph ifFalse: [
		Error signal: 'Can''t popup an anchored window if the element is not attached to a space' ].
	self visibility: BlVisibility hidden. 
	self element space root addChild: self.
	self checkBeforePopupEvent: anEvent.
	self requestLayout.
	popupTimestamp := DateAndTime now.
	self whenLayoutedDoOnce: [
		" I need to finalize my position as soon as my layout is up-to-date "
		self toFront.
		self visibility: BlVisibility visible. 
		self dispatchOpenedEvent: anEvent ]
]

{ #category : 'accessing' }
ToAnchoredWindow >> popupTimestamp [

	^ popupTimestamp 
]
