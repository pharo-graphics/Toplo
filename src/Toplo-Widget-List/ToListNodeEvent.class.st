Class {
	#name : #ToListNodeEvent,
	#superclass : #BlEvent,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeEvent >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListNodeEvent >> listElement: aListElement [

	listElement := aListElement
]
