Class {
	#name : #ToUnselectableSkinEvent,
	#superclass : #ToOtherSelectionSkinEvent,
	#category : #'Toplo-Theme-SkinEvents'
}

{ #category : #accessing }
ToUnselectableSkinEvent >> selected [ 

	^ true
]

{ #category : #sending }
ToUnselectableSkinEvent >> sendTo: anObject [

	anObject unselectableSkinEvent: self
]
