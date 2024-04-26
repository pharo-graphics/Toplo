Class {
	#name : #ToPicsumPhotosGallerySelectionElement,
	#superclass : #ToListPrimarySelectionElement,
	#category : #'Toplo-Examples'
}

{ #category : #accessing }
ToPicsumPhotosGallerySelectionElement >> boundsFrom: aBounds [

	^ aBounds left: (aBounds left - 5)
]

{ #category : #'instance creation' }
ToPicsumPhotosGallerySelectionElement >> newRawSkin [ 

	^ ToPicsumPhotosGallerySelectionSkin new
]
