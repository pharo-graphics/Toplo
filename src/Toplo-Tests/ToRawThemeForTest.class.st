Class {
	#name : #ToRawThemeForTest,
	#superclass : #ToRawTheme,
	#category : #'Toplo-Tests-Core-Window'
}

{ #category : #testing }
ToRawThemeForTest class >> canBeDefault [

	^ false
]

{ #category : #accessing }
ToRawThemeForTest class >> defaultTokenProperties [
	" skin managing need a list of unique stamps . "

	^ { (ToTokenProperty name: #'test-background-color' value: Color white) }
]

{ #category : #accessing }
ToRawThemeForTest >> newSkinInstanceFor: anElement [

	^ ToRawSkin new.
]
