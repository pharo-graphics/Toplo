Class {
	#name : #ToListSelectionCommand,
	#superclass : #Object,
	#instVars : [
		'operation',
		'operationState',
		'next'
	],
	#category : #'Toplo-Widget-List-Selection-Command'
}

{ #category : #hook }
ToListSelectionCommand >> applyOn: anObject [

	self next ifNotNil: [ :n | n applyOn: anObject ]
]

{ #category : #testing }
ToListSelectionCommand >> isDeselection [

	^ self isSelection not


]

{ #category : #testing }
ToListSelectionCommand >> isRequest [

	^ self operationState isRequest


]

{ #category : #testing }
ToListSelectionCommand >> isResult [

	^ self isRequest not


]

{ #category : #testing }
ToListSelectionCommand >> isSelection [

	^ self operation isSelection


]

{ #category : #accessing }
ToListSelectionCommand >> next [

	^ next
]

{ #category : #accessing }
ToListSelectionCommand >> next: aListSelectionAction [

	next := aListSelectionAction
]

{ #category : #accessing }
ToListSelectionCommand >> operation [

	^ operation
]

{ #category : #accessing }
ToListSelectionCommand >> operation: aSelectionOperation [

	operation := aSelectionOperation
]

{ #category : #accessing }
ToListSelectionCommand >> operationState [

	^ operationState
]

{ #category : #accessing }
ToListSelectionCommand >> operationState: anOperationState [

	operationState := anOperationState
]
