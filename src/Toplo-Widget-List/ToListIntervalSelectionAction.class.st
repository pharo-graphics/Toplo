Class {
	#name : #ToListIntervalSelectionAction,
	#superclass : #ToListSelectionAction,
	#instVars : [
		'interval'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #testing }
ToListIntervalSelectionAction class >> isDeprecated [ 

	^ true
]

{ #category : #hook }
ToListIntervalSelectionAction >> applyOn: anObject [

	anObject listIntervalSelectionAction: self.
	super applyOn: anObject
]

{ #category : #accessing }
ToListIntervalSelectionAction >> interval [

	^ interval
]

{ #category : #accessing }
ToListIntervalSelectionAction >> interval: anInterval [

	interval := anInterval
]
