Class {
	#name : #ToListSelectionIntervalAction,
	#superclass : #ToListSelectionAction,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Widget-List-SelectionAction'
}

{ #category : #accessing }
ToListSelectionIntervalAction >> interval [

	^ interval
]

{ #category : #accessing }
ToListSelectionIntervalAction >> interval: anInterval [

	interval := anInterval
]
