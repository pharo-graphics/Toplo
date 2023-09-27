Class {
	#name : #ToCompositeEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'handlers'
	],
	#category : #'Toplo-Core'
}

{ #category : #'handlers accessing' }
ToCompositeEventHandler >> addHandler: anEventHandler [

	handlers := (handlers copyWith: anEventHandler) asSet asArray
]

{ #category : #'api - hooks' }
ToCompositeEventHandler >> disableEventsIn: anElementEventDispatcher [
	self eventsToHandle do: [ :eachEventClass | eachEventClass disableIn: anElementEventDispatcher ]
]

{ #category : #'api - hooks' }
ToCompositeEventHandler >> enableEventsIn: anElementEventDispatcher [
	self eventsToHandle do: [ :eachEventClass | eachEventClass enableIn: anElementEventDispatcher ]
]

{ #category : #'api - accessing' }
ToCompositeEventHandler >> eventsToHandle [
	"I return a collection of element types I may be interested in"
	<return: #Collection of: #'BlEvent class'>	

	^ #()
]

{ #category : #'api - event managing' }
ToCompositeEventHandler >> handleEvent: anEvent [

	^ self handlers do: [ :h |
		  (h wantsEvent: anEvent) ifTrue: [ h handleEvent: anEvent ] ]
]

{ #category : #'handlers accessing' }
ToCompositeEventHandler >> handlers [ 

	^ handlers
]

{ #category : #'handlers accessing' }
ToCompositeEventHandler >> hasHandler: anEventHandler [

	^ handlers includes: anEventHandler 
]

{ #category : #testing }
ToCompositeEventHandler >> hasOwner [
	"Utility #*owner message makes it possible to have a polymorphic way to visualise a tree structure of the elements"
	<return: #Boolean>

	^ false
]

{ #category : #initialization }
ToCompositeEventHandler >> initialize [ 

	super initialize.
	handlers := #()
]

{ #category : #'api - hooks' }
ToCompositeEventHandler >> onInstalledIn: anObject [
]

{ #category : #'api - hooks' }
ToCompositeEventHandler >> onUninstalledIn: anObject [
]

{ #category : #'handlers accessing' }
ToCompositeEventHandler >> removeHandler: anEventHandler [

	handlers := handlers copyWithout: anEventHandler 
]

{ #category : #'api - event managing' }
ToCompositeEventHandler >> wantsEvent: anEvent [

	^ self handlers anySatisfy: [ :h | h wantsEvent: anEvent ]

]
