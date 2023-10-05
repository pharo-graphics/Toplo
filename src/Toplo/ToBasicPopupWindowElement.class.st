Class {
	#name : #ToBasicPopupWindowElement,
	#superclass : #ToAbstractWindowElement,
	#classTraits : 'TToWidget classTrait',
	#instVars : [
		'widgetEventHandler',
		'positionHook',
		'popupTimestamp',
		'associateElement'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToBasicPopupWindowElement >> associateElement [

	^ associateElement 

]

{ #category : #accessing }
ToBasicPopupWindowElement >> associateElement: aWidget [

	aWidget = associateElement ifTrue: [ ^ self ].
	associateElement ifNotNil: [ associateElement removeEventHandler: widgetEventHandler ].
	associateElement := aWidget.
	widgetEventHandler := nil.
	associateElement ifNotNil: [
		widgetEventHandler := self defaultAssociateElementEventHandler window: self.
		associateElement addEventHandler: widgetEventHandler ]
]

{ #category : #'api - displaying' }
ToBasicPopupWindowElement >> checkBeforePopup [

]

{ #category : #'api - displaying' }
ToBasicPopupWindowElement >> close [

	self parentDo: [ :p | 
		super close.
		self dispatchClosedEvent ]

]

{ #category : #initialization }
ToBasicPopupWindowElement >> defaulPositionHook [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToBasicPopupWindowElement >> defaultAssociateElementEventHandler [

	^ self defaultAssociateElementEventHandlerClass new
]

{ #category : #initialization }
ToBasicPopupWindowElement >> defaultAssociateElementEventHandlerClass [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToBasicPopupWindowElement >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 900)
]

{ #category : #'api - displaying' }
ToBasicPopupWindowElement >> dispatchClosedEvent [

	| event |
	event := ToWindowClosedEvent new
		         window: self;
		         yourself.
	self dispatchEvent: event.
	self associateElement ifNotNil: [ :w | w dispatchEvent: event copy]
]

{ #category : #'api - displaying' }
ToBasicPopupWindowElement >> dispatchOpenedEventFrom: anEvent [

	| event |
	event := ToWindowOpenedEvent new
		         window: self;
		         yourself.
	self dispatchEvent: event.
	self associateElement ifNotNil: [ :w | w dispatchEvent: event copy]
]

{ #category : #start }
ToBasicPopupWindowElement >> hasAssociateElement [

	^ self associateElement notNil
]

{ #category : #initialization }
ToBasicPopupWindowElement >> initialize [

	super initialize.
	self positionHook: self defaulPositionHook
]

{ #category : #'api - displaying' }
ToBasicPopupWindowElement >> popup [
	
	self popupEvent: nil
]

{ #category : #'api - displaying' }
ToBasicPopupWindowElement >> popupEvent: anEvent [
	" I have to set the position here "

	self setPositionFromHookOnEvent: anEvent.
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
ToBasicPopupWindowElement >> popupTimestamp [

	^ popupTimestamp 
]

{ #category : #accessing }
ToBasicPopupWindowElement >> positionHook [

	^ positionHook
]

{ #category : #accessing }
ToBasicPopupWindowElement >> positionHook: aValuable [
	" takes the window as argument. Computes the window position according to the given window anchor element "
	
	positionHook := aValuable
]

{ #category : #initialization }
ToBasicPopupWindowElement >> removeWidget [

	self associateElement: nil
]

{ #category : #'api - displaying' }
ToBasicPopupWindowElement >> setPositionFromHook [

	self setPositionFromHookOnEvent: nil
]

{ #category : #'api - displaying' }
ToBasicPopupWindowElement >> setPositionFromHookOnEvent: anEvent [

	self position: (self positionHook value: self value: anEvent).
]

{ #category : #'theme accessing' }
ToBasicPopupWindowElement >> toTheme [

	" try to take the parent widget theme first "
	self associateElement ifNotNil: [ :w | ^ w toTheme ].
	^ super toTheme
]
