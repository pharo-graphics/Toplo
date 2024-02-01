Class {
	#name : #ToListIntervalSelection,
	#superclass : #ToListSelectionCommand,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToListIntervalSelection >> applyOn: anObject [

	self operation applyListIntervalSelection: self on: anObject.
	super applyOn: anObject	
]

{ #category : #accessing }
ToListIntervalSelection >> interval [

	^ interval
]

{ #category : #accessing }
ToListIntervalSelection >> interval: anInterval [

	interval := anInterval
]
