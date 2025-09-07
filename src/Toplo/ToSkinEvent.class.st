Class {
	#name : #ToSkinEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-SkinEvents'
}

{ #category : #accessing }
ToSkinEvent >> disabledElementDo: aBlock [

	self target isDisabled ifFalse: [ ^ self ].
	aBlock value: self target
]

{ #category : #accessing }
ToSkinEvent >> elementDo: aBlock [

	aBlock value: self currentTarget
]

{ #category : #accessing }
ToSkinEvent >> enabledElementDo: aBlock [

	self target isEnabled ifFalse: [ ^ self ].
	aBlock value: self target
]

{ #category : #'instance creation' }
ToSkinEvent >> fromState: aState [
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
