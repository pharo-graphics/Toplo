Class {
	#name : #ToRawSkinBuilder,
	#superclass : #ToAbstractSkinBuilder,
	#category : #'Toplo-Theme-Core'
}

{ #category : #'skin building' }
ToRawSkinBuilder >> skinFor: anElement [

	^ anElement rawSkin
]
