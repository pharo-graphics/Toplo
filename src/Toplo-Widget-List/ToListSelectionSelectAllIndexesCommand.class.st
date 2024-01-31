Class {
	#name : #ToListSelectionSelectAllIndexesCommand,
	#superclass : #ToListSelectionMultipleIndexCommand,
	#instVars : [
		'exclusively'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionSelectAllIndexesCommand >> applyOn: anObject [

	anObject listSelectionSelectAllIndexesCommand: self.
	super applyOn: anObject
]

{ #category : #accessing }
ToListSelectionSelectAllIndexesCommand >> exclusively [

	^ exclusively ifNil: [ exclusively := false ]
]

{ #category : #accessing }
ToListSelectionSelectAllIndexesCommand >> exclusively: aBoolean [

	exclusively := aBoolean
]
