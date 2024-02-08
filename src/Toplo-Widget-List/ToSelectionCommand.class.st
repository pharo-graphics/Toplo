"
My class hierarchy models all the basic actions that can be made on a selection. 

"
Class {
	#name : #ToSelectionCommand,
	#superclass : #Object,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToSelectionCommand >> applyOn: anObject [ 

	self nextDo: [ :n | n applyOn: anObject ]
]

{ #category : #accessing }
ToSelectionCommand >> next [

	^ next
]

{ #category : #accessing }
ToSelectionCommand >> next: aListSelectionAction [

	next := aListSelectionAction
]

{ #category : #hook }
ToSelectionCommand >> nextDo: aBlock [

	self next ifNotNil: [ :n | aBlock value: n ]
]
