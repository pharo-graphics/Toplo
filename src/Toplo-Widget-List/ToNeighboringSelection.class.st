Class {
	#name : #ToNeighboringSelection,
	#superclass : #ToSelectionWithElement,
	#instVars : [
		'nodes'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToNeighboringSelection >> = other [

	super = other ifFalse: [ ^ false ].
	^ nodes = other nodes and: [
				  preComputedBounds = other preComputedBounds ]
]

{ #category : #comparing }
ToNeighboringSelection >> hash [

	^ super hash bitXor: nodes hash
]

{ #category : #accessing }
ToNeighboringSelection >> nodes [

	^ nodes
]

{ #category : #accessing }
ToNeighboringSelection >> nodes: anObject [

	nodes := anObject
]
