Class {
	#name : #ToListSelectionMonoIndexCommand,
	#superclass : #ToListSelectionCommandDeprecated,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListSelectionMonoIndexCommand >> applyOn: anObject [

	anObject listSelectionCherryPickCommand: self.
	super applyOn: anObject
]

{ #category : #accessing }
ToListSelectionMonoIndexCommand >> index [

	^ index
]

{ #category : #accessing }
ToListSelectionMonoIndexCommand >> index: anInteger [

	index := anInteger
]
