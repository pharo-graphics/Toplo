Class {
	#name : #ToPropertyLink,
	#superclass : #ToModelLink,
	#instVars : [
		'property'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #'reading-writing' }
ToPropertyLink >> applyChangeOn: aModel with: aValue [

	property write: aValue to: aModel.
	super applyChangeOn: aModel with: aValue
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

{ #category : #'reading-writing' }
ToPropertyLink >> read: aModel [

	^ property read: aModel
]
