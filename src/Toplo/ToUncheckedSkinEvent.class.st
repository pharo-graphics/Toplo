Class {
	#name : #ToUncheckedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToUncheckedSkinEvent >> sendTo: anObject [

	anObject uncheckedSkinEvent: self
]
