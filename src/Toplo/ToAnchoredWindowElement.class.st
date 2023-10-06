Class {
	#name : #ToAnchoredWindowElement,
	#superclass : #ToAbstractWindowElement,
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'positionHook',
		'sizeHook',
		'popupTimestamp',
		'associateElement',
		'associateElementEventHandler'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowElement >> applyPositionHook [

	self applyPositionHookFromEvent: nil

]

{ #category : #accessing }
ToAnchoredWindowElement >> applyPositionHookFromEvent: anEvent [

	^ self position: (self positionHook value: self value: anEvent)
]

{ #category : #accessing }
ToAnchoredWindowElement >> applySizeHook [

	self applySizeHookFromEvent: nil

]

{ #category : #accessing }
ToAnchoredWindowElement >> applySizeHookFromEvent: anEvent [

	self sizeHook ifNil: [ ^ self ].
	^ self size: (self sizeHook value: self value: anEvent)
]

{ #category : #accessing }
ToAnchoredWindowElement >> associateElement [

	^ associateElement 

]

{ #category : #accessing }
ToAnchoredWindowElement >> associateElement: anElement [

	anElement = associateElement ifTrue: [ ^ self ].
	associateElement ifNotNil: [ associateElement removeEventHandler: associateElementEventHandler ].
	associateElement := anElement.
	associateElementEventHandler := nil.
	associateElement ifNotNil: [
		associateElement associateWindow: self.
		associateElementEventHandler := self defaultAssociateElementEventHandler.
		associateElement addEventHandler: associateElementEventHandler ]
]

{ #category : #'api - displaying' }
ToAnchoredWindowElement >> checkBeforePopup [

	self applyPositionHook.
	self applySizeHook.
]

{ #category : #'api - displaying' }
ToAnchoredWindowElement >> close [

	self parentDo: [ :p | 
		super close.
		self dispatchClosedEvent ]

]

{ #category : #initialization }
ToAnchoredWindowElement >> defaulPositionHook [

	^ [ :w :event | w associateElement bounds inSpace bounds topLeft ]
]

{ #category : #initialization }
ToAnchoredWindowElement >> defaulSizeHook [

	^ nil
]

{ #category : #initialization }
ToAnchoredWindowElement >> defaultAssociateElementEventHandler [

	^ self defaultAssociateElementEventHandlerClass new
]

{ #category : #initialization }
ToAnchoredWindowElement >> defaultAssociateElementEventHandlerClass [

	^ ToAnchoredWindowAssociateElementEventHandler
]

{ #category : #accessing }
ToAnchoredWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : #'api - displaying' }
ToAnchoredWindowElement >> dispatchClosedEvent [

	| event |
	event := ToWindowClosedEvent new.
	self dispatchEvent: event.
	self associateElement ifNotNil: [ :w | w dispatchEvent: event copy]
]

{ #category : #'api - displaying' }
ToAnchoredWindowElement >> dispatchOpenedEventFrom: anEvent [

	| event |
	event := ToWindowOpenedEvent new.
	self dispatchEvent: event.
	self associateElement ifNotNil: [ :w | w dispatchEvent: event copy]
]

{ #category : #start }
ToAnchoredWindowElement >> hasAssociateElement [

	^ self associateElement notNil
]

{ #category : #initialization }
ToAnchoredWindowElement >> initialize [

	super initialize.
	self positionHook: self defaulPositionHook.
	self sizeHook: self defaulSizeHook.
	self fitContent
]

{ #category : #'api - displaying' }
ToAnchoredWindowElement >> popup [
	
	self popupEvent: nil
]

{ #category : #'api - displaying' }
ToAnchoredWindowElement >> popupEvent: anEvent [
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
			self checkBeforePopup ] ]
]

{ #category : #accessing }
ToAnchoredWindowElement >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #accessing }
ToAnchoredWindowElement >> positionHook [

	^ positionHook
]

{ #category : #accessing }
ToAnchoredWindowElement >> positionHook: aValuable [
	" takes the window as argument. Computes the window position according to the given window anchor element "
	
	positionHook := aValuable
]

{ #category : #initialization }
ToAnchoredWindowElement >> removeWidget [

	self associateElement: nil
]

{ #category : #accessing }
ToAnchoredWindowElement >> sizeHook [
	
	^ sizeHook
]

{ #category : #accessing }
ToAnchoredWindowElement >> sizeHook: aValuable [
	
	sizeHook := aValuable
]

{ #category : #'theme accessing' }
ToAnchoredWindowElement >> toTheme [

	" try to take the parent widget theme first "
	self associateElement ifNotNil: [ :w | ^ w toTheme ].
	^ super toTheme
]
