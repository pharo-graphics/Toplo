Class {
	#name : #ToListNodeRemovedEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListNodeRemovedEvent >> node [

	^ node
]

{ #category : #accessing }
ToListNodeRemovedEvent >> node: aNode [

	node := aNode
]

{ #category : #sending }
ToListNodeRemovedEvent >> sendTo: anObject [

	anObject listNodeRemovedEvent: self
]
