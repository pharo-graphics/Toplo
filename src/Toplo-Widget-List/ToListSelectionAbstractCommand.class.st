Class {
	#name : #ToListSelectionAbstractCommand,
	#superclass : #Object,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionAbstractCommand >> applyOn: anObject [

	self next ifNotNil: [ :n | n applyOn: anObject ]
]

{ #category : #accessing }
ToListSelectionAbstractCommand >> next [

	^ next
]

{ #category : #accessing }
ToListSelectionAbstractCommand >> next: aListSelectionAction [

	next := aListSelectionAction
]
