Class {
	#name : #ToTextH0,
	#superclass : #ToTextHeading,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #accessing }
ToTextH0 >> fontSizeIn: anElement [

	^ anElement toTheme fontSize
]

{ #category : #accessing }
ToTextH0 >> headingNumber [

	^0
]

{ #category : #accessing }
ToTextH0 >> lineHeightIn: anElement [

	^ anElement toTheme lineHeight
]
