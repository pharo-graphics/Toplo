Class {
	#name : #ToListSelectionAction,
	#superclass : #Object,
	#instVars : [
		'operation'
	],
	#category : #'Toplo-Widget-List-SelectionAction'
}

{ #category : #accessing }
ToListSelectionAction >> operation [

	^ operation
]

{ #category : #accessing }
ToListSelectionAction >> operation: aSymbol [

	" aSymbol is one of (#add, #remove) "
	operation := aSymbol
]
