Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToAbstractMenuItem,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #accessing }
ToCustomMenuItem >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement: anElement [

	innerElement := anElement.
	self addChild: anElement
]
