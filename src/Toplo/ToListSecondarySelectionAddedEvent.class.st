Class {
	#name : #ToListSecondarySelectionAddedEvent,
	#superclass : #ToListSelectionRequestEvent,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSecondarySelectionAddedEvent >> node [

	^ node
]

{ #category : #accessing }
ToListSecondarySelectionAddedEvent >> node: aNode [

	node := aNode
]
