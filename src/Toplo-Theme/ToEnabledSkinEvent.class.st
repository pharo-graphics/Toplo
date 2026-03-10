Class {
	#name : #ToEnabledSkinEvent,
	#superclass : #ToIntrasicSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #accessing }
ToEnabledSkinEvent >> enabled [ 

	^ true
]

{ #category : #sending }
ToEnabledSkinEvent >> sendTo: anObject [

	anObject enabledSkinEvent: self
]
