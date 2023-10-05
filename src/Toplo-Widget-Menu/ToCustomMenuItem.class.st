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

	ToMenuItemEventHandlerDep.
	^ super defaultEventHandler
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement: anElement [

	innerElement := anElement.
	self addChild: anElement
]
