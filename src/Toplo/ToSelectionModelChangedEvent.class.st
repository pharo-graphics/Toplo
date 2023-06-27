Class {
	#name : #ToSelectionModelChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'model',
		'indexes'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToSelectionModelChangedEvent >> indexes [

	^ indexes
]

{ #category : #accessing }
ToSelectionModelChangedEvent >> indexes: aCollection [

	indexes := aCollection
]

{ #category : #accessing }
ToSelectionModelChangedEvent >> model [

	^ model
]

{ #category : #accessing }
ToSelectionModelChangedEvent >> model: aSelectionModel [

	model := aSelectionModel
]
