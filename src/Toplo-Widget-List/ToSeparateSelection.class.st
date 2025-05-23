Class {
	#name : #ToSeparateSelection,
	#superclass : #ToSelectionWithElement,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToSeparateSelection >> = other [

	^ super = other
		  ifFalse: [ false ]
		  ifTrue: [
			  node = other node and: [
				  preComputedBounds = other preComputedBounds ] ]
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
