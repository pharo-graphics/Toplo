Class {
	#name : #ToActionCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToActionCommand >> action [

	^ action
]

{ #category : #accessing }
ToActionCommand >> action: aValuable [

	action := aValuable
]

{ #category : #hook }
ToActionCommand >> applyOn: anObject [

	anObject addSelectionHolderCommand: self.
	super applyOn: anObject
]
