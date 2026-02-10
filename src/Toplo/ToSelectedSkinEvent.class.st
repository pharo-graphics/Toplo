Class {
	#name : #ToSelectedSkinEvent,
	#superclass : #ToStandardSelectionSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToSelectedSkinEvent >> selected [ 

	^ true
]

{ #category : #sending }
ToSelectedSkinEvent >> sendTo: anObject [

	anObject selectedSkinEvent: self
]
