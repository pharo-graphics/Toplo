Class {
	#name : #ToListScrollCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToListScrollCommand >> applyOn: anObject in: aTarget [

	anObject listScrollCommand: self in: aTarget
]

{ #category : #accessing }
ToListScrollCommand >> index [

	^ index
]

{ #category : #accessing }
ToListScrollCommand >> index: anIndex [

	index := anIndex
]
