Class {
	#name : #ToIntervalSelectionCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToIntervalSelectionCommand >> applyOn: anObject [

	self operation applyIntervalSelection: self on: anObject.
	super applyOn: anObject	
]

{ #category : #accessing }
ToIntervalSelectionCommand >> interval [

	^ interval
]

{ #category : #accessing }
ToIntervalSelectionCommand >> interval: anInterval [

	interval := anInterval
]
