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

{ #category : #'private - selection updating' }
ToSeparateSelection >> newSelectionElementIn: aListElement option: aSelectionRepresentationOption [

	^ Array with: (aSelectionRepresentationOption
			   newSelectionElementIn: aListElement
			   forNodeContainers: (Array with: self node))
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

	^ node
]
