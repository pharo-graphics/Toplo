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
ToThemeForStyleRuleTest >> newSkinFor: anElement [

	^ ToNullSkin instance
]
