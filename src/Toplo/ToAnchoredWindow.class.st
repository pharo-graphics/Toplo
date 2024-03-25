Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToBasicWindowElement,
	#instVars : [
		'popupTimestamp',
		'windowManager',
		'openTask'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindow >> anchorRoot [

	^ self manager anchorRoot
]

{ #category : #accessing }
ToAnchoredWindow >> applyPositionHookFromEvent: anEvent [

	windowManager applyPositionHookFromEvent: anEvent
]

{ #category : #accessing }
ToAnchoredWindow >> applySizeHookFromEvent: anEvent [

	windowManager applySizeHookFromEvent: anEvent
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> checkBeforePopupEvent: anEvent [

	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> close [

	openTask ifNotNil: [ :t | self anchorRoot dequeueTask: openTask].
	self dispatchCloseRequest.
	super close.
	self root removeChildren.
	self dispatchClosedEvent
]

{ #category : #accessing }
ToAnchoredWindow >> closeRequestClass [

	^ ToWindowCloseRequest 
]

{ #category : #accessing }
ToAnchoredWindow >> closedEventClass [

	^ ToWindowClosedEvent 
]

{ #category : #accessing }
ToAnchoredWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> dispatchCloseRequest [

	| event |
	event := self closeRequestClass new.
	self element ifNotNil: [:e | e dispatchEvent: event copy ].
	self dispatchEvent: event.

]

{ #category : #'api - displaying' }
ToAnchoredWindow >> dispatchClosedEvent [

	| event |
	event := self closedEventClass new.
	self element ifNotNil: [:e | e dispatchEvent: event copy ].
	self dispatchEvent: event.

]

{ #category : #'api - displaying' }
ToAnchoredWindow >> dispatchOpenedEvent: anEvent [

	| event |
	event := self openedEventClass new
		         sourceEvent: anEvent;
		         yourself.
	self dispatchEvent: event.
	self element dispatchEvent: event copy
]

{ #category : #accessing }
ToAnchoredWindow >> element [

	^ self manager ifNotNil: [:h | h element]
]

{ #category : #testing }
ToAnchoredWindow >> hasAssociateElement [

	^ self element notNil
]

{ #category : #accessing }
ToAnchoredWindow >> manager [

	^ windowManager 
]

{ #category : #accessing }
ToAnchoredWindow >> manager: aWindowHandler [

	windowManager := aWindowHandler 
]

{ #category : #accessing }
ToAnchoredWindow >> openedEventClass [

	^ ToWindowOpenedEvent 
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> popup [
	
	self popupEvent: nil
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> popupEvent: anEvent [
	" I have to set the position here "

	self manager ifNil: [
		Error signal:
			'Can''t popup an anchored window without window manager' ].
	self hasAssociateElement ifFalse: [
		Error signal:
			'Can''t popup an anchored window without associate element' ].
	self element isAttachedToSceneGraph ifFalse: [
		Error signal:
			'Can''t popup an anchored window if the element is not attached to a space' ].

	openTask ifNotNil: [ ^ self ].
	openTask := BlTaskAction new action: [
		            self isOpened ifFalse: [
			            self anchorRoot addChild: self.
			            self localTheme ifNil: [
				            self localTheme: self element toTheme ].
			            popupTimestamp := DateAndTime now.
			            self dispatchOpenedEvent: anEvent ].
		            self toFront.
		            self checkBeforePopupEvent: anEvent.
		            openTask := nil ].
	self anchorRoot enqueueTask: openTask
]

{ #category : #accessing }
ToAnchoredWindow >> popupTimestamp [

	^ popupTimestamp 
]
