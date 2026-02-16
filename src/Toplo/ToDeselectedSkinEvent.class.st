Class {
	#name : #ToDeselectedSkinEvent,
	#superclass : #ToStandardSelectionSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToDeselectedSkinEvent >> selected [ 

	^ false
]

{ #category : #sending }
ToDeselectedSkinEvent >> sendTo: anObject [

	anObject deselectedSkinEvent: self
]
