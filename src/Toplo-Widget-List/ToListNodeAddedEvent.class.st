Class {
	#name : #ToListNodeAddedEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeAddedEvent >> node [

	^ node
]

{ #category : #accessing }
ToListNodeAddedEvent >> node: aNode [

	node := aNode
]

{ #category : #sending }
ToListNodeAddedEvent >> sendTo: anObject [

	anObject listNodeAddedEvent: self
]
