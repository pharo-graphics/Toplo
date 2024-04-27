Class {
	#name : #ToPicsumPhotosGallerySelectionElement,
	#superclass : #ToListPrimarySelectionElement,
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToPicsumPhotosGallerySelectionElement >> newRawSkin [ 

	^ ToPicsumPhotosGallerySelectionSkin new
]

{ #category : #private }
ToPicsumPhotosGallerySelectionElement >> positionFrom: aPoint [

	^ super positionFrom: (aPoint x - 5) @ aPoint y 
]

{ #category : #private }
ToPicsumPhotosGallerySelectionElement >> sizeFrom: aPoint [

	^ super sizeFrom: (aPoint x + 5) @ aPoint y 
]
