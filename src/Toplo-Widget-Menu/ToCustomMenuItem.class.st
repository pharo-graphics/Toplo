Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToAbstractMenuItem,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToCustomMenuItem >> defaultEventHandler [

	^ ToMenuItemEventHandler new
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement: anElement [

	innerElement := anElement.
	self addChild: anElement.
	anElement border: BlBorder empty
]
