Class {
	#name : #ToListPrimarySelectionElement,
	#superclass : #ToListSelectionElement,
	#category : #'Toplo-Widget-List'
}

{ #category : #'t - initialization dresser' }
ToListPrimarySelectionElement >> defaultDresser [ 

	^ ToListDefaultPrimarySelectionDresser new
]

{ #category : #initialization }
ToListPrimarySelectionElement >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 5
]
