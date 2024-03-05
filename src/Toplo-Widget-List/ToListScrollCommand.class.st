Class {
	#name : #ToListScrollCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToListScrollCommand >> applyOn: anObject for: aTarget [

	anObject listScrollCommand: self for: aTarget
]

{ #category : #accessing }
ToListScrollCommand >> index [

	^ index
]

{ #category : #accessing }
ToListScrollCommand >> index: anIndex [

	index := anIndex
]
