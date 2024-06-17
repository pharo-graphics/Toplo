Class {
	#name : #ToSeparateSelection,
	#superclass : #ToSelectionGroup,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToSeparateSelection >> = other [

	^ node holder position = other node holder position
]

{ #category : #comparing }
ToSeparateSelection >> hash [

	^ super hash bitXor: node hash
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
ToSeparateSelection >> nodes [

	^ Array with: node
]
