Class {
	#name : #ToListSecondarySelectionElement,
	#superclass : #ToListFrontSelectionElement,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'instance creation' }
ToListSecondarySelectionElement >> newRawSkin [ 

	^ ToListSecondarySelectionElementSkin new
]

{ #category : #accessing }
ToListSecondarySelectionElement >> selectionMode [

	^ listElement secondarySelectionMode
]
