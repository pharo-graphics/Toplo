Class {
	#name : #ToUncheckedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToUncheckedSkinEvent >> sendTo: anObject [

	anObject uncheckedSkinEvent: self
]
