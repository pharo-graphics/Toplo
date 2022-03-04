Class {
	#name : #ToActor,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'widget',
		'actors',
		'eventDispatcher'
	],
	#category : #'Toplo-Editor-Core'
}

{ #category : #accessing }
ToActor >> actors [
	<return: #Collection of: #ToActor>

	^ self children
]

{ #category : #'event management' }
ToActor >> addEventHandler: anEventHandler [
	self isAttachedToWidget
		ifTrue: [ self widget addEventHandler: (BlEventForwarder forwardTo: anEventHandler from: self) ]
		ifFalse: [ self eventDispatcher addEventHandler: anEventHandler ]
]

{ #category : #accessing }
ToActor >> allActorsBreadthFirstDo: aBlock [ 
	self actors do: aBlock.
	self actors do: [ :each | each allActorsBreadthFirstDo: aBlock ]
]

{ #category : #accessing }
ToActor >> allActorsDepthFirstDo: aBlock [
	self actors do: [ :each | each allActorsDepthFirstDo: aBlock ].
	self actors do: aBlock
]

{ #category : #accessing }
ToActor >> allChildren [
	<return: #Collection of: #ToActor>

	^ Array streamContents: [ :aStream |
		self children do: [ :each |
			aStream nextPut: each.
			aStream nextPutAll: each allChildren ] ]
]

{ #category : #accessing }
ToActor >> children [
	<return: #Collection of: #ToActor>

	^ actors
]

{ #category : #'event management' }
ToActor >> dispatchEvent: anEvent [
	"If I am attached to the widget I dispatch event to the widget,
	otherwise I dispatch a given event to myself and my children "

	anEvent hasSource
		ifFalse: [ anEvent source: self ].

	"first, we dispatch to my direct listeners"
	self dispatchEventToMyself: anEvent.

	"then let the rest of the element components receive it"
	self isAttachedToWidget
		ifTrue: [ self widget dispatchEvent: anEvent ]
		ifFalse: [ self children do: [ :anActor | anActor dispatchEvent: anEvent ] ]
]

{ #category : #'event management' }
ToActor >> dispatchEventToMyself: anEvent [

	anEvent target: self.
	anEvent forwardingTarget: self.

	(self eventDispatcher wantsEvent: anEvent)
		ifTrue: [ self eventDispatcher dispatchEvent: anEvent ]
]

{ #category : #'event management accessing' }
ToActor >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #accessing }
ToActor >> findActor: anActorClass [
	<return: #ToActor>
	
	^ self
		findActor: anActorClass
		ifFound: #yourself
		ifNone: [ self error: 'Actor of type ', anActorClass name, ' is not found' ]
]

{ #category : #accessing }
ToActor >> findActor: anActorClass ifFound: aFoundBlock [
	"Return an actor that corresponds to a given class.
	Throw error if it is not found"
	
	self class = anActorClass
		ifTrue: [ ^ aFoundBlock value: self ].

	self actors do: [ :eachActor | eachActor findActor: anActorClass ifFound: [ :anActor | ^ aFoundBlock value: anActor ] ].
]

{ #category : #accessing }
ToActor >> findActor: anActorClass ifFound: aFoundBlock ifNone: aNoneBlock [
	"Return an actor that corresponds to a given class.
	Throw error if it is not found"
	
	self
		findActor: anActorClass
		ifFound: [ :anActor | ^ aFoundBlock value: anActor ].
	
	^ aNoneBlock value
]

{ #category : #'event management' }
ToActor >> fireEvent: anEvent [
	"I fire provided event while building an event dispatcher chain
	(from target to the root element) and dispatch the event with it.
	anEvent must not be nil"

	anEvent hasSource
		ifFalse: [ anEvent source: self ].

	"first, we fire to my direct listeners"
	self fireEventToMyself: anEvent.

	"then let the rest of the element components receive it"
	self isAttachedToWidget
		ifTrue: [ self widget fireEvent: anEvent ]
		ifFalse: [ self children do: [ :anActor | anActor fireEvent: anEvent ] ]
]

{ #category : #'event management' }
ToActor >> fireEventToMyself: anEvent [
	
	anEvent forwardingTarget: self.
	anEvent target: self.

	BlEvent fireEvent: anEvent target: self
]

{ #category : #'api - testing' }
ToActor >> hasActor: anActorClass [
	"Return true if I or any of my children is of the given type"
	<return: #Boolean>

	^ self class = anActorClass
		or: [ self actors anySatisfy: [ :eachActor | eachActor hasActor: anActorClass ] ]
]

{ #category : #'api - testing' }
ToActor >> hasActorOfKind: anActorClass [
	"Return true if I or any of my children is of the given type"
	<return: #Boolean>

	^ (self isKindOf: anActorClass)
		or: [ self actors anySatisfy: [ :eachActor | eachActor hasActorOfKind: anActorClass ] ]
]

{ #category : #'api - testing' }
ToActor >> hasOwner [
	"Utility #owner message makes it possible to have a polymorphic way to visualise a tree structure of the elements"
	<return: #Boolean>

	^ self isAttachedToWidget
]

{ #category : #initialization }
ToActor >> initialize [
	super initialize.
	
	eventDispatcher := BlDirectEventDispatcher on: self.
	actors := #().
	
	self initializeListeners
]

{ #category : #initialization }
ToActor >> initializeListeners [
	"Override me to initialize event listeners such as property updates from the view model"
]

{ #category : #'api - testing' }
ToActor >> isAttachedToWidget [
	"Return true if I am attached to a widget element, false otherwise.
	When an actor (look or model) is not attached to the element it can not send or receive events"
	<return: #Boolean>

	^ widget isNotNil
]

{ #category : #'api - hooks' }
ToActor >> onInstalledIn: anElement [
	"Is sent when I am added to an element (or to the other actor which is added to the element)"

	self
		assert: [ widget isNil ]
		description: [ 'Can not install the same look instance on multiple widgets' ].

	widget := anElement.
	
	self transferEventHandlersToWidget
]

{ #category : #'api - hooks' }
ToActor >> onUninstalledIn: anElement [
	"Is sent when I am removed from an element (or from the other actor which was part of the element)"
	
	self removeEventHandlersFromWidget
]

{ #category : #accessing }
ToActor >> owner [
	"Utility #owner message makes it possible to have a polymorphic way to visualise a tree structure of the elements"
	<return: #BlElement>

	^ self widget
]

{ #category : #'private - event management' }
ToActor >> removeEventHandlersFromWidget [
	self widget removeEventHandlersSuchThat: [ :eachEventHandler |
		(eachEventHandler isKindOf: BlEventForwarder) and: [ eachEventHandler eventTarget == self ] ]
]

{ #category : #'event management' }
ToActor >> request: aBrRequest [

	aBrRequest canBePropagated
		ifTrue: [ self fireEvent: aBrRequest ]
		ifFalse: [ self dispatchEvent: aBrRequest ].

	^ aBrRequest response
]

{ #category : #'private - event management' }
ToActor >> transferEventHandlersToWidget [
	| theEventHandlers |
	
	theEventHandlers := self eventDispatcher handlers.
	self eventDispatcher removeEventHandlers.
	
	theEventHandlers do: [ :eachHandler | self widget addEventHandler: (BlEventForwarder forwardTo: eachHandler from: self) ]
]

{ #category : #accessing }
ToActor >> widget [
	<return: #BlElement>
	
	self
		assert: [ self isAttachedToWidget ]
		description: [ 'Must be attached to a widget in order to access it' ].

	^ widget
]

{ #category : #accessing }
ToActor >> widgetDo: aBlockClosure [
	widget ifNotNil: aBlockClosure
]

{ #category : #accessing }
ToActor >> withAllActorsBreadthFirstDo: aBlock [
	aBlock value: self.
	self allActorsBreadthFirstDo: aBlock
]

{ #category : #accessing }
ToActor >> withAllActorsDepthFirstDo: aBlock [
	self allActorsDepthFirstDo: aBlock.
	aBlock value: self
]

{ #category : #accessing }
ToActor >> withAllChildren [
	<return: #Collection of: #ToActor>

	^ { self }, self allChildren
]
