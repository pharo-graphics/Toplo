Class {
	#name : #ToSkinEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToSkinEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : #'instance creation' }
ToSkinEvent >> fromState: aState [
]

{ #category : #sending }
ToSkinEvent >> sendTo: anObject [

	
]

{ #category : #sending }
ToSkinEvent >> sendToStyleSheetSkin: aStyleSheetSkin [

	aStyleSheetSkin sendEventToPropertyWriters: self
]
