Class {
	#name : #ToEnabledSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToEnabledSkinEvent >> enabled [ 

	^ true
]

{ #category : #sending }
ToEnabledSkinEvent >> sendTo: anObject [

	anObject enabledSkinEvent: self
]
