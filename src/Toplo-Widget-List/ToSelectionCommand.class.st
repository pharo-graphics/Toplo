Class {
	#name : #ToSelectionCommand,
	#superclass : #Object,
	#instVars : [
		'sourceEvent',
		'operation',
		'next'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToSelectionCommand >> applyOn: anObject [ 

	self nextDo: [ :n | n applyOn: anObject ]
]

{ #category : #testing }
ToSelectionCommand >> isDeselection [

	^ self isSelection not


]

{ #category : #testing }
ToSelectionCommand >> isSelection [

	^ self operation isSelection


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

{ #category : #accessing }
ToSelectionCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToSelectionCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]
