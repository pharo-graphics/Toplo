Class {
	#name : #ToListDisabledSelectionElement,
	#superclass : #ToListSelectionElement,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #skin }
ToListDisabledSelectionElement >> newRawSkin [ 

	^ ToListDisabledSelectionElementSkin new
]

{ #category : #private }
ToListDisabledSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint - (aListElement padding left / 2 @ 1)
]

{ #category : #private }
ToListDisabledSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ aPoint + ((aListElement padding left / 2) + (aListElement padding right / 2) @ 2)
]
