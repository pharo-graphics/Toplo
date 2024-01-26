"
A ToStyleSheetThemeTest is a test class for testing the behavior of ToStyleSheetTheme
"
Class {
	#name : #ToStyleSheetThemeTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToStyleSheetThemeTest >> testApplicableListenersFor [

	| e space theme |
	e := ToElement new.
	space := BlSpace new.
	theme := ToStyleSheetThemeForTest light.
	space toTheme: theme.
	
	space root addChild: e.
	self assert: (theme applicableListenersFor: e) size equals: 3
	
]

{ #category : #tests }
ToStyleSheetThemeTest >> testApplicableRulesFor [

	| e space theme |
	e := ToElement new.
	space := BlSpace new.
	theme := ToStyleSheetThemeForTest light.
	space toTheme: theme.
	
	space root addChild: e.
	self assert: (theme applicableRulesFor: e) size equals: 1
	
]

{ #category : #tests }
ToStyleSheetThemeTest >> testDefaultElementStampsFor [

	| e theme skin |
	e := BlElement new.
	theme := ToStyleSheetThemeForTest light.
	self assert: (theme defaultElementStampsFor: e) equals: { #'element' }.
	skin := theme newSkinFor: e.
	self assert: (skin isKindOf: ToStyleSheetSkin).
	self assert: (e allStamps includesAll: (theme defaultElementStampsFor: e))
]

{ #category : #tests }
ToStyleSheetThemeTest >> testNewSkinInstanceFor [

	| e theme skin |
	e := BlElement new.
	theme := ToStyleSheetThemeForTest light.
	skin := theme newSkinInstanceFor: e.
	self assert: (skin isKindOf: ToStyleSheetSkin)
]

{ #category : #tests }
ToStyleSheetThemeTest >> testRootRulesFor [

	| e space theme |
	e := BlElement new.
	space := BlSpace new.
	theme := ToStyleSheetThemeForTest light.
	space toTheme: theme.
	
	space root addChild: e.
	self assert: (theme rootRulesFor: e) size equals: 1
	
]

{ #category : #tests }
ToStyleSheetThemeTest >> testSetUpElement [

	| e theme skin |
	e := BlElement new.
	theme := ToStyleSheetThemeForTest light.
	self assert: (theme defaultElementStampsFor: e) equals: { #element }.
	skin := theme newSkinInstanceFor: e.
	self assert: (skin isKindOf: ToStyleSheetSkin).
	self assert: (e allStamps isEmpty).
	theme setUpElement: e.
	self assert: (e allStamps includesAll: (theme defaultElementStampsFor: e))
]

{ #category : #tests }
ToStyleSheetThemeTest >> testSkinClassFor [

	| e theme skinCls |
	e := BlElement new.
	theme := ToStyleSheetThemeForTest light.
	skinCls := theme skinClassFor: e.
	self assert: skinCls identicalTo: ToStyleSheetSkin 
]

{ #category : #tests }
ToStyleSheetThemeTest >> testUnsortedApplicableListenersFor [

	| e space theme |
	e := ToElement new.
	space := BlSpace new.
	theme := ToStyleSheetThemeForTest light.
	space toTheme: theme.
	
	space root addChild: e.
	self assert: (theme unsortedApplicableListenersFor: e) size equals: 5
]
