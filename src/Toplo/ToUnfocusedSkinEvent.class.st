Class {
	#name : #ToUnfocusedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToUnfocusedSkinEvent >> focused [ 

	^ false
]

{ #category : #sending }
ToUnfocusedSkinEvent >> sendTo: anObject [

	anObject unfocusedSkinEvent: self
]
