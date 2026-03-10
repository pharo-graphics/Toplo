Class {
	#name : #ToCheckedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #sending }
ToCheckedSkinEvent >> sendTo: anObject [

	anObject checkedSkinEvent: self
]
