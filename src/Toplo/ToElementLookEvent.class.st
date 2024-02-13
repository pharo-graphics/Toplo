Class {
	#name : #ToElementLookEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core-LookEvents'
}

{ #category : #accessing }
ToElementLookEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : #'instance creation' }
ToElementLookEvent >> fromState: aState [
]

{ #category : #sending }
ToElementLookEvent >> sendTo: anObject [

	anObject elementLookEvent: self
]

{ #category : #sending }
ToElementLookEvent >> sendToStyleSheetSkin: aStyleSheetSkin [

	aStyleSheetSkin sendEventToPropertyWriters: self
]
