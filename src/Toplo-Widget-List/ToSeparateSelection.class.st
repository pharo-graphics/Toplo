Class {
	#name : #ToSeparateSelection,
	#superclass : #ToSelectionWithElement,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToSeparateSelection >> equivalentTo: other [

	(super equivalentTo: other) ifFalse: [ ^ false ].
	^ (node equals: other node)
]

{ #category : #accessing }
ToSeparateSelection >> node [

	^ node
]

{ #category : #accessing }
ToSeparateSelection >> node: anObject [

	node := anObject
]

{ #category : #accessing }
ToSeparateSelection >> nodeContainers [

	^ Array with: node
]
