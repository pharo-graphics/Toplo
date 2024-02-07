Class {
	#name : #ToSelectionModelCommand,
	#superclass : #Object,
	#instVars : [
		'operation',
		'next'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToSelectionModelCommand >> applyOn: anObject [ 

	self nextDo: [ :n | n applyOn: anObject ]
]

{ #category : #testing }
ToSelectionModelCommand >> isDeselection [

	^ self isSelection not


]

{ #category : #testing }
ToSelectionModelCommand >> isSelection [

	^ self operation isSelection


]

{ #category : #accessing }
ToSelectionModelCommand >> next [

	^ next
]

{ #category : #accessing }
ToSelectionModelCommand >> next: aListSelectionAction [

	next := aListSelectionAction
]

{ #category : #hook }
ToSelectionModelCommand >> nextDo: aBlock [

	self next ifNotNil: [ :n | aBlock value: n ]
]

{ #category : #accessing }
ToSelectionModelCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToSelectionModelCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]
