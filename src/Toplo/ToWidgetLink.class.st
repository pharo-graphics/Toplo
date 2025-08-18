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

{ #category : #initialization }
ToWidgetLink >> onWidget: anElement [

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
