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

	self addedHandler: anEventHandler in: self for: nil
]

{ #category : #adding }
ToWidgetLink >> addedHandler: anEventHandler in: aTarget for: aReceiver [

	self
		addEventHandlerOn: ToWidgetLinkDissociateEvent
		doOnce: [ :event |
				aTarget removeEventHandler: anEventHandler.
				aReceiver ifNotNil: [ aReceiver removeWidgetLink: self ] ]
]

{ #category : #'event management accessing' }
ToWidgetLink >> eventDispatcher [
	"Return an object responsible for event dispatching"

	<return: #BlDirectEventDispatcher>
	^ eventDispatcher ifNil: [
		  eventDispatcher := BlDirectEventDispatcher on: self ]
]

{ #category : #initialization }
ToWidgetLink >> link: anObjectOrValuable withWidget: aCheckable [

	self subclassResponsibility 
]

{ #category : #initialization }
ToWidgetLink >> unlink [

	self dispatchEvent: ToWidgetLinkDissociateEvent new
]
