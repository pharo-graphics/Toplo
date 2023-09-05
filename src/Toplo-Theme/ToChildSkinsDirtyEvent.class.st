Class {
	#name : #ToChildSkinsDirtyEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Theme-Skin'
}

{ #category : #sending }
ToChildSkinsDirtyEvent >> sendTo: anObject [

	anObject childSkinsDirtyEvent: self
]
