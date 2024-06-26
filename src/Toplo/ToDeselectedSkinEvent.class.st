Class {
	#name : #ToDeselectedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToDeselectedSkinEvent >> sendTo: anObject [

	anObject deselectedSkinEvent: self
]
