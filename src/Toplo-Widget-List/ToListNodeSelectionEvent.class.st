Class {
	#name : #ToListNodeSelectionEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'selected'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeSelectionEvent >> selected [

	^ selected
]

{ #category : #accessing }
ToListNodeSelectionEvent >> selected: aBoolean [

	selected := aBoolean
]

{ #category : #sending }
ToListNodeSelectionEvent >> sendTo: anObject [

	anObject listNodeSelectionEvent: self
]
