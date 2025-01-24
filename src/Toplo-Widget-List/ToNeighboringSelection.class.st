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

	self class = other class ifFalse: [ ^ false ].
	nodes size = other nodes size ifFalse: [ ^ false ].
	1 to: nodes size do: [ :index |
		(nodes at: index) = (other nodes at: index) ifFalse: [ ^ false ] ].

	^ true
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
