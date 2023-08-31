Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToAbstractMenuItem,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - initialization dresser' }
ToCustomMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser new
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
