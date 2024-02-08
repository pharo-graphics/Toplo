Class {
	#name : #ToSelectionHolderCommand,
	#superclass : #ToSelectionCommand,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #accessing }
ToSelectionHolderCommand >> action [

	^ action
]

{ #category : #accessing }
ToSelectionHolderCommand >> action: aValuable [

	action := aValuable
]

{ #category : #hook }
ToSelectionHolderCommand >> applyOn: anObject [

	anObject addSelectionHolderCommand: self.
	super applyOn: anObject
]
