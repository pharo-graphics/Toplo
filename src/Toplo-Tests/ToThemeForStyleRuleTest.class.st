Class {
	#name : #ToThemeForStyleRuleTest,
	#superclass : #ToTheme,
	#category : #'Toplo-Tests-Core-StyleSheet'
}

{ #category : #accessing }
ToThemeForStyleRuleTest class >> label [ 

	^ 'A theme class for tests'
]

{ #category : #accessing }
ToThemeForStyleRuleTest >> newSkinInstanceFor: anElement [

	^ ToNullSkin new
]

{ #category : #hook }
ToThemeForStyleRuleTest >> setUpElement: anElement [

	super setUpElement: anElement.
	anElement setUpByTheme: self
]
