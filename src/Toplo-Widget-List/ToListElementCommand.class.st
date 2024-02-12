"
My class hierarchy models all the basic actions that can be made on a selection. 

"
Class {
	#name : #ToListElementCommand,
	#superclass : #Object,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #hook }
ToListElementCommand >> applyOn: anObject [ 

	self nextDo: [ :n | n applyOn: anObject ]
]

{ #category : #accessing }
ToListElementCommand >> next [

	^ next
]

{ #category : #accessing }
ToListElementCommand >> next: aListSelectionAction [

	next := aListSelectionAction
]

{ #category : #hook }
ToListElementCommand >> nextDo: aBlock [

	self next ifNotNil: [ :n | aBlock value: n ]
]
