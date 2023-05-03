Class {
	#name : #ToDataFilteredEvent,
	#superclass : #BlEvent,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToDataFilteredEvent >> data [

	^ data
]

{ #category : #accessing }
ToDataFilteredEvent >> data: aCollection [

	data := aCollection
]
