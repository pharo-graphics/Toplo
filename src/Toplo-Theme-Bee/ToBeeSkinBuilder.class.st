Class {
	#name : #ToBeeSkinBuilder,
	#superclass : #ToStyleSheetSkinBuilder,
	#category : #'Toplo-Theme-Bee'
}

{ #category : #'skin building' }
ToBeeSkinBuilder >> skinClassFor: anElement [

	^ ToBeeSkin
]

{ #category : #'writer selecting' }
ToBeeSkinBuilder >> writersFor: anElement [

	anElement withAllStamps: anElement defaultBeeStyleStamps.
	^ super writersFor: anElement

]
