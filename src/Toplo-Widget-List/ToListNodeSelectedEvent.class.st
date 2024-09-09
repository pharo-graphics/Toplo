Class {
	#name : #ToListNodeSelectedEvent,
	#superclass : #ToListNodeEvent,
	#instVars : [
		'listElement',
		'selected',
		'selectionOption'
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

{ #category : #accessing }
ToListNodeSelectedEvent >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToListNodeSelectedEvent >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]

{ #category : #sending }
ToListNodeSelectedEvent >> sendTo: anObject [

	anObject listNodeSelectedEvent: self
]
