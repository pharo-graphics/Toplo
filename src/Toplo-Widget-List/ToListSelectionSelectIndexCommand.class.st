Class {
	#name : #ToListSelectionSelectIndexCommand,
	#superclass : #ToListSelectionMonoIndexCommand,
	#instVars : [
		'exclusively'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionSelectIndexCommand >> applyOn: anObject [

	anObject listSelectionSelectIndexCommand: self.
	super applyOn: anObject
]

{ #category : #accessing }
ToListSelectionSelectIndexCommand >> exclusively [

	^ exclusively ifNil: [ exclusively := false ]
]

{ #category : #accessing }
ToListSelectionSelectIndexCommand >> exclusively: aBoolean [

	exclusively := aBoolean
]
