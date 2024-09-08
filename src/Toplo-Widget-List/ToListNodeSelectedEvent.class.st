Class {
	#name : #ToListNodeSelectedEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'listElement',
		'selected'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeSelectedEvent >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListNodeSelectedEvent >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #accessing }
ToListNodeSelectedEvent >> selected [

	^ selected
]

{ #category : #accessing }
ToListNodeSelectedEvent >> selected: aBoolean [

	selected := aBoolean
]

{ #category : #sending }
ToListNodeSelectedEvent >> sendTo: anObject [

	anObject listNodeSelectedEvent: self
]
