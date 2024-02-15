Class {
	#name : #ToListSelectionAction,
	#superclass : #Object,
	#instVars : [
		'operation',
		'next'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #testing }
ToListSelectionAction class >> isDeprecated [ 

	^ true
]

{ #category : #hook }
ToListSelectionAction >> applyOn: anObject [

	self next ifNotNil: [ :n | n applyOn: anObject ]
]

{ #category : #testing }
ToListSelectionAction >> isDeselection [

	^ self operation = #deselection


]

{ #category : #testing }
ToListSelectionAction >> isSelection [

	^ self operation = #selection


]

{ #category : #testing }
ToListSelectionAction >> isShift [

	^ self operation = #shift


]

{ #category : #accessing }
ToListSelectionAction >> next [

	^ next
]

{ #category : #accessing }
ToListSelectionAction >> next: aListSelectionAction [

	next := aListSelectionAction
]

{ #category : #accessing }
ToListSelectionAction >> operation [

	^ operation
]

{ #category : #accessing }
ToListSelectionAction >> operation: aSymbol [

	" aSymbol is one of (#selection, #deselection, #shift) "
	operation := aSymbol
]
