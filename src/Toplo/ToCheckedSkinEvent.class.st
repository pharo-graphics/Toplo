Class {
	#name : #ToCheckedSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToCheckedSkinEvent >> checked [ 

	^ true
]

{ #category : #sending }
ToCheckedSkinEvent >> sendTo: anObject [

	anObject checkedSkinEvent: self
]
