"
A ToDefaultStyleSheetTest is a test class for testing the behavior of ToDefaultStyleSheet
"
Class {
	#name : #ToDefaultStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-DefaultTheme'
}

{ #category : #skin }
ToDefaultStyleSheetTest >> testDefaultButtonSkin [

	| ss button looks skin labelSkin |
	ss := ToDefaultStyleSheet new.
	button := ToButton new.
	looks := ss lookUpdatersFor: button.
	self assert: looks notEmpty.
	skin := ToWidgetSkin new.
	skin addAllLookUpdaters: looks.
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
	looks := ss lookUpdatersFor: button label.
	labelSkin addAllLookUpdaters: looks.
	button label withSkin: labelSkin.
	button checkSkinInstallation.
	
	
]

{ #category : #skin }
ToDefaultStyleSheetTest >> testDefaultButtonSkin0 [

	| ss button looks skin labelSkin |
	ss := ToDefaultStyleSheet new.
	button := ToButton new.
	looks := ss lookUpdatersFor: button.
	self assert: looks notEmpty.
	skin := ToWidgetSkin new.
	skin addAllLookUpdaters: looks.
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
	looks := ss lookUpdatersFor: button label.
	labelSkin addAllLookUpdaters: looks.
	button label privateSkin: labelSkin.
	button checkSkinInstallation.
	
	
]

{ #category : #skin }
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

{ #category : #skin }
ToDefaultStyleSheetTest >> testJustifiedButtonSkin1 [

	| ss button skin |
	ss := ToDefaultStyleSheet new.
	button := ToButton new.
	skin := ss skinFor: button.
	button withSkin: skin.
	button
		iconImage: Smalltalk ui theme windowCloseForm;
		labelText: 'close'.
	button addStyleClass: #justified.
	button checkSkinInstallation.
	self assert: button privateSkin class identicalTo: ToWidgetSkin.
	self assert: button label privateSkin class identicalTo: ToWidgetSkin.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self
		assert: button border paint color
		equals: button toTheme colorBorder
]

{ #category : #skin }
ToDefaultStyleSheetTest >> testJustifiedButtonSkin2 [

	| ss button skin |
	ss := ToDefaultStyleSheet new.
	button := ToButton new.
	skin := ss skinFor: button.
	button withSkin: skin.
	button
		iconImage: Smalltalk ui theme windowCloseForm;
		labelText: 'close'.
	button addStyleClass: #justified.
	button switchToSkinState: ToInstallState new.
	button switchToSkinState: ToInitialState new.
	
	self assert: button privateSkin class identicalTo: ToWidgetSkin.
	self assert: button label privateSkin class identicalTo: ToWidgetSkin.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self
		assert: button border paint color
		equals: button toTheme colorBorder
]

{ #category : #skin }
ToDefaultStyleSheetTest >> testJustifiedButtonSkin3 [

	| ss button skin |
	ss := ToDefaultStyleSheet new.
	button := ToButton new.
	skin := ss skinFor: button.
	button withSkin: skin.
	button
		iconImage: Smalltalk ui theme windowCloseForm;
		labelText: 'close'.
	button addStyleClass: #justified.
	button switchToSkinState: ToInstallState new.
	button switchToSkinState: ToInitialState new.
	button openInSpace.
	self assert: button privateSkin class identicalTo: ToWidgetSkin.
	self assert: button label privateSkin class identicalTo: ToWidgetSkin.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self
		assert: button border paint color
		equals: button toTheme colorBorder
]

{ #category : #skin }
ToDefaultStyleSheetTest >> testJustifiedButtonSkin4 [

| b ss space |
ss := ToDefaultStyleSheet new.
b := ToButton new.
b styleSheet: ss.
"b addStyleClass: #primary. "
b addStyleClass: #round.
b addStyleClass: #justified.
"b addStyleClass: #vertical."
"b addStyleClass: #link. "
"b addStyleClass: #danger."
b	
	iconImage: Smalltalk ui theme windowCloseForm; 
	labelText: 'close'.
space := BlSpace new.
space root addChild: b.
space root forceLayout.
"b openInSpace."
]

{ #category : #'look updaters' }
ToDefaultStyleSheetTest >> testPropertyList [

	| ss index count |
	ss := ToDefaultStyleSheet new.
	index := IdentityDictionary new.
	ss propertyList do: [ :p |
		index at: p name ifAbsentPut: [ 0 ].
		count := (index at: p name) + 1.
		index at: p name put: count ].
	index keysAndValuesDo: [ :k :v | self assert: v identicalTo: 1 ].
	ss propertyList do: [ :p | self assert: (ss newLookUpdaterForPropertyName: p name) notNil ]
]
