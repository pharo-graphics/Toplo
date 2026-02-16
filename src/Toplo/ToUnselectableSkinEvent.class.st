Class {
	#name : #ToUnselectableSkinEvent,
	#superclass : #ToOtherSelectionSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToUnselectableSkinEvent >> selected [ 

	^ true
]

{ #category : #sending }
ToUnselectableSkinEvent >> sendTo: anObject [

	anObject unselectableSkinEvent: self
]
