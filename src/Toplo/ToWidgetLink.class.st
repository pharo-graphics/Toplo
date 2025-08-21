Class {
	#name : #ToWidgetLink,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher',
		'widget'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #'handlers management' }
ToWidgetLink >> addedHandler: anEventHandler in: aTarget [

	self
		addEventHandlerOn: ToWidgetLinkDissociateEvent
		doOnce: [ :event |
				aTarget removeEventHandler: anEventHandler ]
]

{ #category : #'event management accessing' }
ToWidgetLink >> eventDispatcher [
	"Return an object responsible for event dispatching"

	<return: #BlDirectEventDispatcher>
	^ eventDispatcher ifNil: [
		  eventDispatcher := BlDirectEventDispatcher on: self ]
]

{ #category : #running }
ToWidgetLink >> launchWithLinkedObject: anObjectOrValuable from: aTarget onEvent: anEvent withValue: aValue [

	| space action |
	aTarget isDisabled ifTrue: [ ^ self ].
	action := [
	          self
		          runWithLinkedObject: anObjectOrValuable
		          from: aTarget
		          onEvent: anEvent
		          withValue: aValue ].
	space := aTarget space.
	space
		ifNil: [ aTarget inUIProcessDo: action ]
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
ToWidgetLink >> run [

	self dispatchEvent: ToRunLinkActionRequest new
]

{ #category : #running }
ToWidgetLink >> runWithEvent: anEvent [

	self dispatchEvent: (ToRunLinkActionRequest new
			 sourceEvent: anEvent;
			 yourself)
]

{ #category : #running }
ToWidgetLink >> runWithLinkedObject: anObject from: aTarget onEvent: anEvent withValue: aValue [
	self widget: anElement
]

{ #category : #initialization }
ToWidgetLink >> unlink [
  
	self dispatchEvent: ToWidgetLinkDissociateEvent new.
	widget := nil
]

{ #category : #accessing }
ToWidgetLink >> widget: anElement [

	widget := anElement
]
