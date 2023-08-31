Class {
	#name : #ToTextH5,
	#superclass : #ToTextHeading,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #accessing }
ToTextH5 >> fontSizeIn: anElement [

	^ anElement toTheme fontSizeHeading5
]

{ #category : #accessing }
ToTextH5 >> headingNumber [

	^5
]

{ #category : #accessing }
ToTextH5 >> lineHeightIn: anElement [

	^ anElement toTheme lineHeightHeading5
]
