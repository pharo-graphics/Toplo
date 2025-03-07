Class {
	#name : #ToPropertyLink,
	#superclass : #ToWidgetLink,
	#instVars : [
		'property'
	],
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #running }
ToPropertyLink >> applyChangeIn: aModel onEvent: anEvent withValue: aValue [

	property write: aValue to: aModel.
	super applyChangeIn: aModel onEvent: anEvent withValue: aValue
]

{ #category : #initialization }
ToPropertyLink >> configureToUpdate: aValueOwner fromModel: aModel [

	self subclassResponsibility 
]

{ #category : #initialization }
ToPropertyLink >> link: aWidget withModel: aModel reader: aReader [

	property := ToFeatureProperty new
		            name: aReader;
		            yourself.
	self configureToUpdate: aWidget fromModel: aModel.
	self configureToUpdateModel: aModel from: aWidget
]

{ #category : #initialization }
ToPropertyLink >> link: aWidget withModel: aModel reader: aReader writer: aWriter [

	property := ToFeatureProperty new
		            name: aReader;
		            writerName: aWriter;
		            yourself.
	self configureToUpdate: aWidget fromModel: aModel.
	self configureToUpdateModel: aModel from: aWidget
]

{ #category : #running }
ToPropertyLink >> onModelValueChangedDo: aValuable [

	self addedHandler: (self
			 addEventHandlerOn: ToModelChangedEvent
			 do: [ :evt | aValuable value: (self read: evt model) ])
]

{ #category : #running }
ToPropertyLink >> read: aModel [

	^ property read: aModel
]
