Class {
	#name : #ToNeighboringSelection,
	#superclass : #ToSelectionGroup,
	#instVars : [
		'nodes'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToNeighboringSelection >> nodes [

	^ nodes
]

{ #category : #accessing }
ToNeighboringSelection >> nodes: anObject [

	nodes := anObject
]
