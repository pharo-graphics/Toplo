Class {
	#name : #ToSelectionModelChanged,
	#superclass : #Announcement,
	#instVars : [
		'model',
		'indexes'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToSelectionModelChanged >> indexes [

	^ indexes
]

{ #category : #accessing }
ToSelectionModelChanged >> indexes: aCollection [

	indexes := aCollection
]

{ #category : #accessing }
ToSelectionModelChanged >> model [

	^ model
]

{ #category : #accessing }
ToSelectionModelChanged >> model: aSelectionModel [

	model := aSelectionModel
]
