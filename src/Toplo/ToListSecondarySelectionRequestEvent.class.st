Class {
	#name : #ToListSecondarySelectionRequestEvent,
	#superclass : #ToListSelectionRequestEvent,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSecondarySelectionRequestEvent >> node [

	^ node
]

{ #category : #accessing }
ToListSecondarySelectionRequestEvent >> node: aNode [

	node := aNode
]
