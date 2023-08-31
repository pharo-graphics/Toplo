Class {
	#name : #ToTextH1,
	#superclass : #ToTextHeading,
	#category : #'Toplo-Widget-Album-Skin-Label'
}

{ #category : #accessing }
ToTextH1 >> fontSizeIn: anElement [

	^ anElement toTheme fontSizeHeading1
]

{ #category : #accessing }
ToTextH1 >> headingNumber [

	^1
]

{ #category : #accessing }
ToTextH1 >> lineHeightIn: anElement [

	^ anElement toTheme lineHeightHeading1 
]
