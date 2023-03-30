Class {
	#name : #ToListSecondarySelectionRemovedEvent,
	#superclass : #ToListSelectionRequestEvent,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSecondarySelectionRemovedEvent >> node [

	^ node
]

{ #category : #accessing }
ToListSecondarySelectionRemovedEvent >> node: aNode [

	node := aNode
]
