Class {
	#name : #ToListPrimarySelectionElement,
	#superclass : #ToListFrontSelectionElement,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #private }
ToListPrimarySelectionElement >> computeBounds [
	" compute my bounds from my list of adjacent nodes. "

	| bnds |
	bnds := self boundsFromNodes.
	self position: (self positionFrom: bnds origin).
	self size: (self sizeFrom: bnds extent)
]

{ #category : #'instance creation' }
ToListPrimarySelectionElement >> newRawSkin [ 

	^ ToListPrimarySelectionElementSkin new
]

{ #category : #accessing }
ToListPrimarySelectionElement >> selectionMode [

	^ listElement selectionMode
]
