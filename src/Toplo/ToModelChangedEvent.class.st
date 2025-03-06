Class {
	#name : #ToModelChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'model',
		'writtenValue'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #accessing }
ToModelChangedEvent >> model [

	^ model
]

{ #category : #accessing }
ToModelChangedEvent >> model: anObject [

	model := anObject
]

{ #category : #accessing }
ToModelChangedEvent >> writtenValue [

	^ writtenValue
]

{ #category : #accessing }
ToModelChangedEvent >> writtenValue: anObject [

	writtenValue := anObject
]
