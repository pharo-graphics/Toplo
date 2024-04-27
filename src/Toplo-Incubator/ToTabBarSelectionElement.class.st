Class {
	#name : #ToTabBarSelectionElement,
	#superclass : #ToListPrimarySelectionElement,
	#category : #'Toplo-Incubator'
}

{ #category : #'instance creation' }
ToTabBarSelectionElement >> newRawSkin [ 

	^ ToTabBarSelectionElementSkin new
]

{ #category : #private }
ToTabBarSelectionElement >> positionFrom: aPoint [

	^ super positionFrom: aPoint x @ (aPoint y + nodes first measuredHeight)
]

{ #category : #private }
ToTabBarSelectionElement >> sizeFrom: aPoint [

	^ super sizeFrom: aPoint x @ 5

]
