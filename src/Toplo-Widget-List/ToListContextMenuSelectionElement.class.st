Class {
	#name : #ToListContextMenuSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'inner'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #initialization }
ToListContextMenuSelectionElement >> initialize [

	super initialize.
	inner := ToElement new
		         id: #inner;
		         yourself.
	inner matchParent.
	self addChild: inner
]

{ #category : #accessing }
ToListContextMenuSelectionElement >> inner [

	^ inner
]

{ #category : #skin }
ToListContextMenuSelectionElement >> newRawSkin [ 

	^ ToListContextMenuSelectionElementSkin new
]

{ #category : #private }
ToListContextMenuSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint - (aListElement padding left / 2 @ 0)
]

{ #category : #private }
ToListContextMenuSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ aPoint + ((aListElement padding left / 2) + (aListElement padding right / 2) @ 0)
]
