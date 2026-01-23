Class {
	#name : #ToSelectionWithoutElement,
	#superclass : #ToEmptySelectionRepresentation,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToSelectionWithoutElement >> equivalentTo: other [

	(super equivalentTo: other) ifFalse: [ ^ false ].
	^ node equals: other node
]

{ #category : #accessing }
ToSelectionWithoutElement >> node [

	^ node
]

{ #category : #accessing }
ToSelectionWithoutElement >> node: anObject [

	node := anObject
]

{ #category : #accessing }
ToSelectionWithoutElement >> nodeContainers [

	^ Array with: node
]
