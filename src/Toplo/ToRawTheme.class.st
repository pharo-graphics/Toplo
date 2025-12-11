Class {
	#name : #ToRawTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToRawTheme class >> canBeDefault [

	^ true
]

{ #category : #initialization }
ToRawTheme class >> initializeToRawTheme: aTheme [
	" for the space root element "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (aTheme id: BlSpace defaultRootLabel) style: [
			aTheme write: (aTheme property: #background) with: [ :e |
					(e valueOfTokenNamed: #'background-color')
						ifNotNil: [ :bgc | bgc ]
						ifNil: [ Color red ] ] ]
]

{ #category : #accessing }
ToRawTheme class >> label [

	^'Raw'
]

{ #category : #'skin creation' }
ToRawTheme >> defaultSkinFor: anElement [

	^ anElement defaultRawSkin ifNil: [
		  super defaultSkinFor: anElement ]
]

{ #category : #'skin creation' }
ToRawTheme >> newSkinFor: anElement [

	^ anElement newRawSkin
]
