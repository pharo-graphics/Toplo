Class {
	#name : #ToListNodeSelectedEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'selected'
	],
	#category : #'Toplo-Widget-List-Node'
}

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
