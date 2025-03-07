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

{ #category : #'reading-writing' }
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

{ #category : #'reading-writing' }
ToWidgetLink >> onModelValueChangedDo: aValuable [

	self
		addEventHandlerOn: ToModelChangedEvent
		do: [ :evt | aValuable value: (self read: evt model) ]
]
