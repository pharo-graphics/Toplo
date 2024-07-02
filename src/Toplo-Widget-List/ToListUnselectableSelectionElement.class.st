Class {
	#name : #ToListUnselectableSelectionElement,
	#superclass : #ToListSelectionElement,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #skin }
ToListUnselectableSelectionElement >> newRawSkin [ 

	^ ToListUnselectableSelectionElementSkin new
]

{ #category : #private }
ToListUnselectableSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint - (aListElement padding left / 2 @ 1)
]

{ #category : #private }
ToListUnselectableSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ aPoint + ((aListElement padding left / 2) + (aListElement padding right / 2) @ 2)
]
