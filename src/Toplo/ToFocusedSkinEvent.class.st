Class {
	#name : #ToFocusedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToFocusedSkinEvent >> focused [ 

	^ true
]

{ #category : #sending }
ToFocusedSkinEvent >> sendTo: anObject [

	anObject focusedSkinEvent: self
]
