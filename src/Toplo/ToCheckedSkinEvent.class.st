Class {
	#name : #ToCheckedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToCheckedSkinEvent >> sendTo: anObject [

	anObject checkedSkinEvent: self
]
