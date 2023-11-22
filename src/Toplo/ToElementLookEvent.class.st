Class {
	#name : 'ToElementLookEvent',
	#superclass : 'BlEvent',
	#category : 'Toplo-Core-LookEvents',
	#package : 'Toplo',
	#tag : 'Core-LookEvents'
}

{ #category : 'accessing' }
ToElementLookEvent >> elementDo: aBlock [

	aBlock value: self target
]

{ #category : 'sending' }
ToElementLookEvent >> sendTo: anObject [

	anObject elementLookEvent: self
]

{ #category : 'sending' }
ToElementLookEvent >> sendToStyleSheetSkin: aStyleSheetSkin [

	aStyleSheetSkin sendEventToPropertyWriters: self
]
