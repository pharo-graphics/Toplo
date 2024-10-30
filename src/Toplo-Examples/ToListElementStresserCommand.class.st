Class {
	#name : #ToListElementStresserCommand,
	#superclass : #Object,
	#instVars : [
		'round',
		'list',
		'listNumber'
	],
	#category : #'Toplo-Examples-Stressers'
}

{ #category : #accessing }
ToListElementStresserCommand >> list [

	^ list
]

{ #category : #accessing }
ToListElementStresserCommand >> list: anObject [

	list := anObject
]

{ #category : #accessing }
ToListElementStresserCommand >> listNumber [

	^ listNumber
]

{ #category : #accessing }
ToListElementStresserCommand >> listNumber: anObject [

	listNumber := anObject
]

{ #category : #accessing }
ToListElementStresserCommand >> round [

	^ round
]

{ #category : #accessing }
ToListElementStresserCommand >> round: anObject [

	round := anObject
]
