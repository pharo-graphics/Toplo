Class {
	#name : #ToTextH3,
	#superclass : #ToTextHeading,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #accessing }
ToTextH3 >> fontSizeIn: anElement [

	^ anElement toTheme fontSizeHeading3
]

{ #category : #accessing }
ToTextH3 >> headingNumber [

	^3
]

{ #category : #accessing }
ToTextH3 >> lineHeightIn: anElement [

	^ anElement toTheme lineHeightHeading3
]
