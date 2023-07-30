Class {
	#name : #ToTextH4,
	#superclass : #ToTextHeading,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToTextH4 >> fontSizeIn: anElement [

	^ anElement toTheme fontSizeHeading4
]

{ #category : #accessing }
ToTextH4 >> headingNumber [

	^4
]

{ #category : #accessing }
ToTextH4 >> lineHeightIn: anElement [

	^ anElement toTheme lineHeightHeading4
]
