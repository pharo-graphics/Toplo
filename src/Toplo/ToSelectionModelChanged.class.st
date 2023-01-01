Class {
	#name : #ToSelectionModelChanged,
	#superclass : #Announcement,
	#instVars : [
		'model',
		'interval'
	],
	#category : #'Toplo-Core-Infinite'
}

{ #category : #accessing }
ToSelectionModelChanged >> interval [

	^ interval
]

{ #category : #accessing }
ToSelectionModelChanged >> interval: anInterval [

	interval := anInterval
]

{ #category : #accessing }
ToSelectionModelChanged >> model [

	^ model
]

{ #category : #accessing }
ToSelectionModelChanged >> model: aSelectionModel [

	model := aSelectionModel
]
