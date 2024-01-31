Class {
	#name : #ToListNodeEvent,
	#superclass : #BlEvent,
	#instVars : [
		'infiniteElement',
		'node'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeEvent >> infiniteElement [

	^ infiniteElement
]

{ #category : #accessing }
ToListNodeEvent >> infiniteElement: aListElement [

	infiniteElement := aListElement
]

{ #category : #accessing }
ToListNodeEvent >> node [

	^ node
]

{ #category : #accessing }
ToListNodeEvent >> node: aListNode [

	node := aListNode
]
