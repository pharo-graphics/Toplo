Class {
	#name : #ToWidgetLink,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #adding }
ToWidgetLink >> addedHandler: anEventHandler [

	self addedHandler: anEventHandler in: self
]

{ #category : #adding }
ToWidgetLink >> addedHandler: anEventHandler in: aTarget [

	self
		addEventHandlerOn: ToWidgetLinkDissociateEvent
		doOnce: [ :event | aTarget removeEventHandler: anEventHandler ]
]

{ #category : #initialization }
ToWidgetLink >> configureToUpdateLinkedObject: anObject from: aValueProvider [

	self subclassResponsibility 
]

{ #category : #'event management accessing' }
ToWidgetLink >> eventDispatcher [
	"Return an object responsible for event dispatching"

	<return: #BlDirectEventDispatcher>
	^ eventDispatcher ifNil: [
		  eventDispatcher := BlDirectEventDispatcher on: self ]
]

{ #category : #running }
ToWidgetLink >> launchWithLinkedObject: anObject from: aTarget onEvent: anEvent withValue: aValue [

	| space action |
	action := [
	          self
		          runWithLinkedObject: anObject
		          from: aTarget
		          onEvent: anEvent
		          withValue: aValue ].
	space := aTarget space.
	space
		ifNil: [ aTarget enqueueTask: (BlTaskAction new action: action) ]
		ifNotNil: [ action value ]
]

{ #category : #running }
ToWidgetLink >> onActionRunnedDo: aValuable [

	self addedHandler:
		(self addEventHandlerOn: ToLinkActionRunnedEvent do: [ :evt |
			 aValuable
				 cull: evt sourceEvent
				 cull: evt linkedObject
				 cull: evt changedValue ])
]

{ #category : #running }
ToWidgetLink >> runWithLinkedObject: anObject from: aTarget onEvent: anEvent withValue: aValue [

	| space time evt |
	space := aTarget space.
	time := space ifNotNil: [ :sp | sp time ].
	evt := ToLinkActionRunnedEvent new
		       fillFromTime: time;
		       linkedObject: anObject;
		       sourceEvent: anEvent;
		       changedValue: aValue;
		       yourself.
	self dispatchEvent: evt.
	aTarget = self ifTrue: [ ^ self ].
	aTarget fireEvent: evt copy
]

{ #category : #initialization }
ToWidgetLink >> unlink [

	self dispatchEvent: ToWidgetLinkDissociateEvent new
]
