Class {
	#name : #ToEmptySkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Empty'
}

{ #category : #'event handling' }
ToEmptySkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e layout alignCenter.
			(e hasStamp: #waiting) ifTrue: [
					e userData at: #waitingImage ifAbsent: [
							e userData
								at: #waitingImage
								put: (self waitingAnimatedImageIn: e).
							e installInnerImage: (e userData at: #waitingImage) ] ].
			(e hasStamp: #box) ifTrue: [
					e installInnerImage: (e valueOfTokenNamed: #empty_box).
					e image
						extent: (e valueOfTokenNamed: #'empty-image-size') asPoint;
						innerImageColor:
							(e valueOfTokenNamed: #'color-text-placeholder') ] ]
]

{ #category : #accessing }
ToEmptySkin >> waitingAnimatedImageIn: anEmpty [

	| image |
	image := ToWaitingAnimatedIcon new.
	image sectorThickness: 
		(anEmpty valueOfTokenNamed: #'empty-sector-height').
	image extent:
		(anEmpty valueOfTokenNamed: #'empty-image-size') asPoint.
	image sectorBackground:
		(anEmpty valueOfTokenNamed: #'color-text-placeholder').
	^ image
]
