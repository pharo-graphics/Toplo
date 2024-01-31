Class {
	#name : #ToListSelectionCommand,
	#superclass : #Object,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionCommand >> applyOn: anObject [

	self next ifNotNil: [ :n | n applyOn: anObject ]
]

{ #category : #accessing }
ToListSelectionCommand >> next [

	^ next
]

{ #category : #accessing }
ToListSelectionCommand >> next: aListSelectionAction [

	next := aListSelectionAction
]
