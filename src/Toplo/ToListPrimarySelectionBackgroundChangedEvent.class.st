Class {
	#name : #ToListPrimarySelectionBackgroundChangedEvent,
	#superclass : #ToListSelectionEvent,
	#instVars : [
		'background'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListPrimarySelectionBackgroundChangedEvent >> background [

	^ background
]

{ #category : #accessing }
ToListPrimarySelectionBackgroundChangedEvent >> background: aBackground [

	background := aBackground
]
