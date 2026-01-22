Class {
	#name : #ToNeighboringSelection,
	#superclass : #ToSelectionWithElement,
	#instVars : [
		'nodes'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToNeighboringSelection >> equivalentTo: other [

	(super equivalentTo: other) ifFalse: [ ^ false ].
	nodes size = other nodeContainers size ifFalse: [ ^ false ].
	nodes
		with: other nodeContainers
		do: [ :c1 :c2 | (c1 equals: c2) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
ToNeighboringSelection >> nodeContainers [

	^ nodes
]

{ #category : #accessing }
ToNeighboringSelection >> nodes: anObject [

	nodes := anObject
]
