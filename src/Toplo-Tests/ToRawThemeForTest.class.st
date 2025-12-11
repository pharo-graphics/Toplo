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
	" the #'background-color' token is mandatory because of the RawTheme space root initialization.
	(see ToRawTheme class>>initializeToRawTheme:) "

	^ {
		  (ToTokenProperty name: #'background-color' value: Color green).
		  (ToTokenProperty name: #'test-background-color' value: Color white) }
]

{ #category : #'skin creation' }
ToRawThemeForTest >> newSkinFor: anElement [

	^ ToRawSkin new
]
