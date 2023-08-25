Class {
	#name : #ToChildSkinsDirtyEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Theme'
}

{ #category : #sending }
ToChildSkinsDirtyEvent >> sendTo: anObject [

	anObject childSkinsDirtyEvent: self
]
