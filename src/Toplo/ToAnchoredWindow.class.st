Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToAbstractWindowElement,
	#instVars : [
		'popupTimestamp',
		'windowHandler'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindow >> applyPositionHookFromEvent: anEvent [

	^ windowHandler applyPositionHookFromEvent: anEvent
]

{ #category : #accessing }
ToAnchoredWindow >> applySizeHookFromEvent: anEvent [

	windowHandler applySizeHookFromEvent: anEvent
]

{ #category : #accessing }
ToAnchoredWindow >> associateElement [

	^ windowHandler ifNotNil: [:h | h element]
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> checkBeforePopupEvent: anEvent [

	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent.
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> close [

	self parentDo: [ :p | super close ].
	self dispatchClosedEvent
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
ToAnchoredWindow >> dispatchClosedEvent [

	| event |
	event := self closedEventClass new.
	self associateElement ifNotNil: [ :w | w dispatchEvent: event ].
	self dispatchEvent: event copy.

]

{ #category : #'api - displaying' }
ToAnchoredWindow >> dispatchOpenedEvent: anEvent [

	| event |
	event := self openedEventClass new
		         sourceEvent: anEvent;
		         yourself.
	self dispatchEvent: event.
	self associateElement ifNotNil: [ :w | w dispatchEvent: event copy ]
]

{ #category : #accessing }
ToAnchoredWindow >> handler: aWindowHandler [

	windowHandler := aWindowHandler 
]

{ #category : #start }
ToAnchoredWindow >> hasAssociateElement [

	^ self associateElement notNil
]

{ #category : #initialization }
ToAnchoredWindow >> initialize [

	super initialize.
	self fitContent
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

	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent.
	self hasParent ifTrue: [ ^ self ].
	self associateElement space root addChild: self.
	self dispatchOpenedEvent: anEvent. 
	popupTimestamp := DateAndTime now.
	"I need to finalize my position as soon as my layout is up-to-date"
	self whenLayoutedDoOnce: [
		self associateElement isAttachedToSceneGraph ifTrue: [
			self checkBeforePopupEvent: anEvent ] ]
]

{ #category : #accessing }
ToAnchoredWindow >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #'theme accessing' }
ToAnchoredWindow >> toTheme [

	" try to take the parent widget theme first "
	self associateElement ifNotNil: [ :w | ^ w toTheme ].
	^ super toTheme
]
