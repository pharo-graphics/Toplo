Class {
	#name : #ToListSelectionDecorationEvent,
	#superclass : #BlEvent,
	#instVars : [
		'decoration'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSelectionDecorationEvent >> decoration [

	^ decoration
]

{ #category : #accessing }
ToListSelectionDecorationEvent >> decoration: aDecoration [

	decoration := aDecoration
]
