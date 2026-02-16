Class {
	#name : #ToSkinEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToSkinEvent >> elementDo: aBlock [

	aBlock value: self currentTarget
]

{ #category : #sending }
ToSkinEvent >> sendTo: anObject [

	
]

{ #category : #sending }
ToSkinEvent >> sendToSkin: aSkin [

	self sendTo: aSkin

	
]

{ #category : #sending }
ToSkinEvent >> sendToStyleSheetSkin: aStyleSheetSkin [

	aStyleSheetSkin sendEventToPropertyWriters: self
]
