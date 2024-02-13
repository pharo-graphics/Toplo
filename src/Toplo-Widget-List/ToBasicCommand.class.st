"
My class hierarchy models all the basic actions that can be made on a selection. 

"
Class {
	#name : #ToBasicCommand,
	#superclass : #Object,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #hook }
ToBasicCommand >> applyOn: anObject [ 

	self nextDo: [ :n | n applyOn: anObject ]
]

{ #category : #accessing }
ToBasicCommand >> next [

	^ next
]

{ #category : #accessing }
ToBasicCommand >> next: aListSelectionAction [

	next := aListSelectionAction
]

{ #category : #hook }
ToBasicCommand >> nextDo: aBlock [

	self next ifNotNil: [ :n | aBlock value: n ]
]
