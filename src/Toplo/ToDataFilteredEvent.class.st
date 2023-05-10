Class {
	#name : #ToDataFilteredEvent,
	#superclass : #BlEvent,
	#instVars : [
		'data',
		'indexes'
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

{ #category : #accessing }
ToDataFilteredEvent >> indexes [

	^ indexes
]

{ #category : #accessing }
ToDataFilteredEvent >> indexes: aCollection [

	indexes := aCollection
]
