Class {
	#name : #ToWholeSelectionCommand,
	#superclass : #ToSelectionModelCommand,
	#instVars : [
		'maxIndex'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #hook }
ToWholeSelectionCommand >> applyOn: anObject [

	self operation applyWholeSelection: self on: anObject.
	super applyOn: anObject	
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex [

	^ maxIndex
]

{ #category : #accessing }
ToWholeSelectionCommand >> maxIndex: anIndex [

	maxIndex := anIndex
]
