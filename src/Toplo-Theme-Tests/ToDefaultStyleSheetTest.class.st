"
A ToDefaultStyleSheetTest is a test class for testing the behavior of ToDefaultStyleSheet
"
Class {
	#name : #ToDefaultStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-DefaultTheme'
}

{ #category : #tests }
ToDefaultStyleSheetTest >> testDefaultButtonSkin [

	| ss button looks skin labelSkin |
	ss := ToDefaultStyleSheet new.
	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks notEmpty.
	skin := ToWidgetSkin new.
	skin addAllLooks: looks.
	button withSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: button toTheme colorBorder.
	
	button labelText: 'Default'.
	button label privateSkin: nil.
	
	labelSkin := ToWidgetSkin new.
	looks := ss looksFor: button label.
	labelSkin addAllLooks: looks.
	button label withSkin: labelSkin.
	button checkSkinInstallation.
	
	
]

{ #category : #tests }
ToDefaultStyleSheetTest >> testDefaultButtonSkin0 [

	| ss button looks skin labelSkin |
	ss := ToDefaultStyleSheet new.
	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks notEmpty.
	skin := ToWidgetSkin new.
	skin addAllLooks: looks.
	button withSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: button toTheme colorBorder.
	
	button labelText: 'Default'.
	button label privateSkin: nil.
	
	labelSkin := ToWidgetSkin new.
	looks := ss looksFor: button label.
	labelSkin addAllLooks: looks.
	button label privateSkin: labelSkin.
	button checkSkinInstallation.
	
	
]

{ #category : #tests }
ToDefaultStyleSheetTest >> testDefaultButtonSkin1 [

	| ss button skin labelSkin |
	ss := ToDefaultStyleSheet new.
	button := ToButton new.
	skin := ss skinFor: button.
	button withSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button labelText: 'Default'.
	labelSkin := ss skinFor: button label.
	button label privateSkin: labelSkin.
	button checkSkinInstallation.
	self assert: button privateSkin class == ToWidgetSkin.
	self assert: button label privateSkin class == ToWidgetSkin.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: button toTheme colorBorder.
	
]
