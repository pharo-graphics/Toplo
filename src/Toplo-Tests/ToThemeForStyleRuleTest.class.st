Class {
	#name : 'ToThemeForStyleRuleTest',
	#superclass : 'ToTheme',
	#category : 'Toplo-Tests-Core-StyleSheet',
	#package : 'Toplo-Tests',
	#tag : 'Core-StyleSheet'
}

{ #category : 'accessing' }
ToThemeForStyleRuleTest >> name [

	^ 'A theme for style rules testing'
]

{ #category : 'accessing' }
ToThemeForStyleRuleTest >> newSkinInstanceFor: anElement [

	^ ToNullSkin new
]

{ #category : 'hook' }
ToThemeForStyleRuleTest >> setUpElement: anElement [

	super setUpElement: anElement.
	anElement setUpByTheme: self
]
