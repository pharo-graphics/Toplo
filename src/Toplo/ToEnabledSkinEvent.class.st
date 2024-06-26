Class {
	#name : #ToEnabledSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #sending }
ToEnabledSkinEvent >> sendTo: anObject [

	anObject enabledSkinEvent: self
]
