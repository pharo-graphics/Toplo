Class {
	#name : #ToListSelectionCommandDeprecated,
	#superclass : #Object,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #testing }
ToListSelectionCommandDeprecated class >> isDeprecated [ 

	^ true
]

{ #category : #hook }
ToListSelectionCommandDeprecated >> applyOn: anObject [

	self next ifNotNil: [ :n | n applyOn: anObject ]
]

{ #category : #accessing }
ToListSelectionCommandDeprecated >> next [

	^ next
]

{ #category : #accessing }
ToListSelectionCommandDeprecated >> next: aListSelectionAction [

	next := aListSelectionAction
]
