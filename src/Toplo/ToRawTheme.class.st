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

	<toploThemeInstallerFor: #ToRawTheme>
	" for the space root element "
	aTheme select: (aTheme id: #'space-root') style: [
			aTheme
				write: (aTheme property: #background)
				with: [ :e | e valueOfTokenNamed: #'background-color' ] ]
]

{ #category : #accessing }
ToRawTheme class >> label [

	^'Raw'
]

{ #category : #accessing }
ToRawTheme >> defaultSkinFor: anElement [

	^ anElement defaultRawSkin ifNil: [
		  super defaultSkinFor: anElement ]
]

{ #category : #accessing }
ToRawTheme >> newSkinFor: anElement [

	^ anElement newRawSkin forElement: anElement inTheme: self
]
