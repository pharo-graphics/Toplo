Class {
	#name : #ToChildSkinsDirtyEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-Theme-skins'
}

{ #category : #sending }
ToChildSkinsDirtyEvent >> sendTo: anObject [

	anObject childSkinsDirtyEvent: self
]
