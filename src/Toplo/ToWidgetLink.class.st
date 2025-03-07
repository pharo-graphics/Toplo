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

{ #category : #running }
ToWidgetLink >> applyChangeOn: aModel with: aValue [

	self dispatchEvent: (ToModelChangedEvent new
			 model: aModel;
			 writtenValue: aValue;
			 yourself)
]

{ #category : #initialization }
ToWidgetLink >> configureToUpdateModel: aModel from: aValueProvider [

	self subclassResponsibility 
]

{ #category : #'event management accessing' }
ToWidgetLink >> eventDispatcher [
	"Return an object responsible for event dispatching"

	<return: #BlDirectEventDispatcher>
	^ eventDispatcher ifNil: [
		  eventDispatcher := BlDirectEventDispatcher on: self ]
]

{ #category : #initialization }
ToWidgetLink >> unlink [

	self dispatchEvent: ToWidgetLinkDissociateEvent new
]
