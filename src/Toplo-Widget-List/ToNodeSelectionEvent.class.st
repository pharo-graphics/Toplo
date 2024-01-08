Class {
	#name : #ToNodeSelectionEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selected',
		'infiniteElement'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToNodeSelectionEvent >> infiniteElement [

	^ infiniteElement
]

{ #category : #accessing }
ToNodeSelectionEvent >> infiniteElement: aListElement [

	infiniteElement := aListElement
]

{ #category : #accessing }
ToNodeSelectionEvent >> selected [

	^ selected
]

{ #category : #accessing }
ToNodeSelectionEvent >> selected: aBoolean [

	selected := aBoolean
]

{ #category : #sending }
ToNodeSelectionEvent >> sendTo: anObject [

	anObject listNodeSelectionEvent: self
]
