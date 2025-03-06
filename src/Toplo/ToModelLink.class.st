Class {
	#name : #ToModelLink,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #'reading-writing' }
ToModelLink >> applyChangeOn: aModel with: aValue [

	self dispatchEvent: (ToModelChangedEvent new
			 model: aModel;
			 writtenValue: aValue;
			 yourself)
]

{ #category : #initialization }
ToModelLink >> configureToUpdateModel: aModel from: aValueProvider [

	self subclassResponsibility 
]

{ #category : #'event management accessing' }
ToModelLink >> eventDispatcher [
	"Return an object responsible for event dispatching"

	<return: #BlDirectEventDispatcher>
	^ eventDispatcher ifNil: [
		  eventDispatcher := BlDirectEventDispatcher on: self ]
]

{ #category : #'reading-writing' }
ToModelLink >> onModelValueChangedDo: aValuable [

	self
		addEventHandlerOn: ToModelChangedEvent
		do: [ :evt | aValuable value: (self read: evt model) ]
]
