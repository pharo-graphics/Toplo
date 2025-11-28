Class {
	#name : #ToSelectionWithoutElement,
	#superclass : #ToEmptySelectionRepresentation,
	#instVars : [
		'node'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #comparing }
ToSelectionWithoutElement >> = other [

	^ super = other
		  ifFalse: [ false ]
		  ifTrue: [ node = other node ]
]

{ #category : #comparing }
ToSelectionWithoutElement >> hash [

	^ super hash bitXor: node hash
]

{ #category : #accessing }
ToSelectionWithoutElement >> node [

	^ node
]

{ #category : #accessing }
ToSelectionWithoutElement >> node: anObject [

	node := anObject
]

{ #category : #accessing }
ToSelectionWithoutElement >> nodeContainers [

	^ Array with: node
]
