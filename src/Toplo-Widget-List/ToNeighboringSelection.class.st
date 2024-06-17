Class {
	#name : #ToNeighboringSelection,
	#superclass : #ToSelectionGroup,
	#instVars : [
		'nodes'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToNeighboringSelection >> = other [

	^ (nodes collect: [ :n | n holder dataItem ])
	  = (other nodes collect: [ :n | n holder dataItem ])
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
