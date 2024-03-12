Class {
	#name : #ToListScrollCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToListScrollCommand >> applyOn: anOperator in: aTarget [

	anOperator listScrollCommand: self in: aTarget.
	super applyOn: anOperator in: aTarget
]

{ #category : #accessing }
ToListScrollCommand >> index [

	^ index
]

{ #category : #accessing }
ToListScrollCommand >> index: anIndex [

	index := anIndex
]
