Class {
	#name : #ToAnchoredWindow,
	#superclass : #ToAbstractWindowElement,
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'positionHook',
		'sizeHook',
		'popupTimestamp',
		'associateElement'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindow >> applyPositionHook [

	self applyPositionHookFromEvent: nil

]

{ #category : #accessing }
ToAnchoredWindow >> applyPositionHookFromEvent: anEvent [

	^ self position: (self positionHook value: self value: anEvent)
]

{ #category : #accessing }
ToAnchoredWindow >> applySizeHook [

	self applySizeHookFromEvent: nil

]

{ #category : #accessing }
ToAnchoredWindow >> applySizeHookFromEvent: anEvent [

	self sizeHook ifNil: [ ^ self ].
	^ self size: (self sizeHook value: self value: anEvent)
]

{ #category : #accessing }
ToAnchoredWindow >> associateElement [

	^ associateElement 

]

{ #category : #accessing }
ToAnchoredWindow >> associateElement: anElement [

	associateElement := anElement
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> checkBeforePopupEvent: anEvent [

	self applyPositionHookFromEvent: anEvent.
	self applySizeHookFromEvent: anEvent.
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> close [

	self parentDo: [ :p |
		super close.
		self dispatchClosedEvent].
	self associateElement dissociateFromWindow

]

{ #category : #initialization }
ToAnchoredWindow >> defaulPositionHook [

	^ [ :w :event | w associateElement bounds inSpace bounds topLeft ]
]

{ #category : #initialization }
ToAnchoredWindow >> defaulSizeHook [

	^ nil
]

{ #category : #initialization }
ToAnchoredWindow >> defaultAssociateElementEventHandler [

	^ self defaultAssociateElementEventHandlerClass new
]

{ #category : #initialization }
ToAnchoredWindow >> defaultAssociateElementEventHandlerClass [

	^ ToAnchoredWindowAssociateElementEventHandler
]

{ #category : #accessing }
ToAnchoredWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> dispatchClosedEvent [

	| event |
	event := ToWindowClosedEvent new.
	self dispatchEvent: event.
	self associateElement ifNotNil: [ :w | w dispatchEvent: event copy]
]

{ #category : #'api - displaying' }
ToAnchoredWindow >> dispatchOpenedEventFrom: anEvent [

	| event |
	event := ToWindowOpenedEvent new.
	self dispatchEvent: event.
	self associateElement ifNotNil: [ :w | w dispatchEvent: event copy]
]

{ #category : #start }
ToAnchoredWindow >> hasAssociateElement [

	^ self associateElement notNil
]

{ #category : #initialization }
ToAnchoredWindow >> initialize [

	super initialize.
	self positionHook: self defaulPositionHook.
	self sizeHook: self defaulSizeHook.
	self fitContent
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
	self dispatchOpenedEventFrom: anEvent. 
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

{ #category : #accessing }
ToAnchoredWindow >> positionHook [

	^ positionHook
]

{ #category : #accessing }
ToAnchoredWindow >> positionHook: aValuable [
	" takes the window as argument. Computes the window position according to the given window anchor element "
	
	positionHook := aValuable
]

{ #category : #accessing }
ToAnchoredWindow >> sizeHook [
	
	^ sizeHook
]

{ #category : #accessing }
ToAnchoredWindow >> sizeHook: aValuable [
	
	sizeHook := aValuable
]

{ #category : #'theme accessing' }
ToAnchoredWindow >> toTheme [

	" try to take the parent widget theme first "
	self associateElement ifNotNil: [ :w | ^ w toTheme ].
	^ super toTheme
]
