Class {
	#name : #ToListPrimarySelectionElement,
	#superclass : #ToListFrontSelectionElement,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'instance creation' }
ToListPrimarySelectionElement >> newRawSkin [ 

	^ ToListPrimarySelectionElementSkin new
]

{ #category : #private }
ToListPrimarySelectionElement >> sizeFrom: aPoint [

	^ super sizeFrom: aPoint "(listElement primarySelectionSizeFrom: aPoint)"
]
