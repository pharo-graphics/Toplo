"
A ToPrimaryButtonSkinTest is a test class for testing the behavior of ToPrimaryButtonSkin
"
Class {
	#name : #ToPrimaryButtonSkinTest,
	#superclass : #ToThemeTestCase,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Skins - Buttons'
}

{ #category : #tests }
ToPrimaryButtonSkinTest >> testInitialize [

	| button |
	button := ToButton skinType: #primary.
	button labelText: 'Button'.
	
	self assert: button skinType equals: #primary.
	self assert: button skin class equals: ToPrimaryButtonSkin.
	
	self assert: button label skinType equals: #primary.
	self assert: button label skin class equals: ToPrimaryLabelSkin.
]
