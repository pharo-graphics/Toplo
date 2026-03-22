Class {
	#name : #ToUncheckedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToUncheckedSkinEvent >> checked [ 

	^ false
]

{ #category : #sending }
ToUncheckedSkinEvent >> sendTo: anObject [

	anObject uncheckedSkinEvent: self
]
