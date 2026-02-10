Class {
	#name : #ToSelectableSkinEvent,
	#superclass : #ToOtherSelectionSkinEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToSelectableSkinEvent >> selected [ 

	^ false
]

{ #category : #sending }
ToSelectableSkinEvent >> sendTo: anObject [

	anObject selectableSkinEvent: self
]
