Class {
	#name : #ToSelectedSkinEvent,
	#superclass : #ToStandardSelectionSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #accessing }
ToSelectedSkinEvent >> selected [ 

	^ true
]

{ #category : #sending }
ToSelectedSkinEvent >> sendTo: anObject [

	anObject selectedSkinEvent: self
]
