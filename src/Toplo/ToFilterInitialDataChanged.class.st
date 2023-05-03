Class {
	#name : #ToFilterInitialDataChanged,
	#superclass : #BlEvent,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Examples'
}

{ #category : #accessing }
ToFilterInitialDataChanged >> data [

	^ data
]

{ #category : #accessing }
ToFilterInitialDataChanged >> data: aCollection [

	data := aCollection
]
