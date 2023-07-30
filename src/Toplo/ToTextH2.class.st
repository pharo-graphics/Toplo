Class {
	#name : #ToTextH2,
	#superclass : #ToTextHeading,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToTextH2 >> fontSizeIn: anElement [

	^ anElement toTheme fontSizeHeading2
]

{ #category : #accessing }
ToTextH2 >> headingNumber [

	^2
]

{ #category : #accessing }
ToTextH2 >> lineHeightIn: anElement [

	^ anElement toTheme lineHeightHeading2
]
