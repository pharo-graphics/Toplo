Class {
	#name : #ToTextH4,
	#superclass : #ToTextHeading,
	#category : #'Toplo-Widget-Album-Skin-Label'
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
