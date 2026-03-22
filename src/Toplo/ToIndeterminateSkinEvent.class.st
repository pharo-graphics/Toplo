Class {
	#name : #ToIndeterminateSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToIndeterminateSkinEvent >> checked [ 

	^ nil
]

{ #category : #sending }
ToIndeterminateSkinEvent >> sendTo: anObject [

	anObject indeterminateSkinEvent: self
]
