"
A ToStyleSheetManagerTest is a test class for testing the behavior of ToStyleSheetManager
"
Class {
	#name : 'ToStyleStoreTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'tests' }
ToStyleStoreTest >> testAddStamp [

	| e s s2 |
	e := BlElement new.
	e toStyleStore addStamp: (#color -> Color blue) asStyleStamp.
	self assert: (s := e toStyleStore localStampNamed: #color) notNil.
	self assert: (s isKindOf: ToReadOnlyStyleStamp).
	self assert: s name equals: #color.
	self assert: s value equals: Color blue.
	self assert: e toStyleStore readOnlyStampIndex size equals: 1.
	e withStamp: (#color -> Color red) asStyleStamp.
	self assert: (s2 := e toStyleStore localStampNamed: #color) notNil.
	self assert: s2 name equals: #color.
	self assert: s2 value equals: Color red.
	self assert: s ~~ s2.
	self assert: e toStyleStore readOnlyStampIndex size equals: 1
]

{ #category : 'tests' }
ToStyleStoreTest >> testBorderBuilder [

	| e  |
	e := BlElement new.
	self assert: (e toStyleStore borderBuilder ) notNil
]

{ #category : 'tests' }
ToStyleStoreTest >> testHasStampNamed [

	| e |
	e := BlElement new.
	self deny: (e hasStampNamed: #color).
	e withStamp: (#color -> Color blue) asStyleStamp.
	self assert: (e hasStampNamed: #color).
	e withStamp: (#background -> Color blue) asStyleStamp.
	e withStamp: (#layout -> BlLinearLayout horizontal) asStyleStamp.
	e withStamp: (#something -> #something) asStyleStamp.
	self assert: (e hasStampNamed: #something).
	self assert: (e hasStampNamed: #color).

]

{ #category : 'tests' }
ToStyleStoreTest >> testIsSetUpForTheme [

	| e theme skin space |
	e := BlElement new.
	space := BlSpace new.
	theme := ToRawTheme new.
	self deny: (e toStyleStore isSetUpForTheme: theme).
	self assert: e toStyleStore themeClasses isEmpty.
	self assert: ((theme newSkinFor: e) isKindOf: ToRawSkin).
	space root addChild: e.
	skin := theme newSkinFor: e.
	self assert: e toStyleStore themeClasses size equals: 1.
	self assert: e toStyleStore themeClasses anyOne equals: ToRawTheme
]

{ #category : 'tests' }
ToStyleStoreTest >> testLocalStampNamed [

	| e s |
	e := BlElement new.
	self assert: (e toStyleStore localStampNamed: #color) isNil.
	(e toStyleStore readOnlyStampIndex)
		addProperty: #color asStyleStamp.
	s := e toStyleStore localStampNamed: #color.
	self assert: s notNil.
	self assert: (s isKindOf: ToReadOnlyStyleStamp).
	self assert: s name equals: #color.
	self assert: s value
]

{ #category : 'tests' }
ToStyleStoreTest >> testLookUpStampNamedFrom [

	| e child |
	e := BlElement new.
	child := BlElement new.
	e withStamp: (#color -> Color blue) asStyleStamp.
	self assert: e toStyleStore readOnlyStampIndex size equals: 1.
	self
		assert: (e toStyleStore lookUpStampNamed: #color from: e)
		identicalTo: (e toStyleStore localStampNamed: #color).
	e addChild: child.
	self
		assert: (child toStyleStore lookUpStampNamed: #color from: child)
		identicalTo: (e toStyleStore localStampNamed: #color).
	child withStamp: (#color -> Color red) asStyleStamp.
	self
		assert: (child toStyleStore lookUpStampNamed: #color from: child)
		identicalTo: (child toStyleStore localStampNamed: #color).
	self
		assert: (child toStyleStore lookUpStampNamed: #something from: child) isNil
]

{ #category : 'tests' }
ToStyleStoreTest >> testOnInstalledIn [

	| e |
	e := BlElement new.
	self assert: e toStyleStore themeClasses notNil.
	self assert: e toStyleStore themeClasses isEmpty.
	self deny: e skinManager hasPostponedRequestInstallSkin.
	self assert: e skinInstaller isNil.
	e toStyleStore readOnlyStampIndex changedAction value.
	self assert: e skinManager hasPostponedRequestInstallSkin.
	self assert: e skinInstaller isNil
]

{ #category : 'tests' }
ToStyleStoreTest >> testRegisterTheme [

	| e |
	e := BlElement new.
	self assert: e toStyleStore themeClasses notNil.
	self assert: e toStyleStore themeClasses isEmpty.
	e toStyleStore registerTheme: ToRawTheme new.
	self assert: e toStyleStore themeClasses size equals: 1.
	self assert: e toStyleStore themeClasses anyOne = ToRawTheme
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveStampNamed [

	| e |
	e := BlElement new.
	e withStamp: (#color1 -> Color blue) asStyleStamp.
	e withStamp: (#color2 -> Color blue) asStyleStamp.
	self assert: e toStyleStore readOnlyStampIndex size equals: 2.
	e toStyleStore removeStampNamed: #color1.
	self assert: e toStyleStore readOnlyStampIndex size = 1.
	e toStyleStore removeStampNamed: #color2.
	self assert: e toStyleStore readOnlyStampIndex isEmpty
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveStyleStampNamed [

	| e |
	e := BlElement new.
	e withStamp: (#color -> Color blue) asStyleStamp.
	self assert: e toStyleStore readOnlyStampIndex size equals: 1.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore readOnlyStampIndex isEmpty.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore readOnlyStampIndex isEmpty
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveStyleStampNamedIfAbsent [

	| e |
	e := BlElement new.
	e withStamp: (#color -> Color blue) asStyleStamp.
	self assert: e toStyleStore readOnlyStampIndex size equals: 1.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore readOnlyStampIndex isEmpty.
	e toStyleStore removeStampNamed: #color.
	e withStamp: (#color -> Color red) asStyleStamp.
	self assert: e toStyleStore readOnlyStampIndex size equals: 1.
	e toStyleStore removeStampNamed: #blob .
	self assert: e toStyleStore readOnlyStampIndex size equals: 1.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore readOnlyStampIndex isEmpty.


]

{ #category : 'tests' }
ToStyleStoreTest >> testSetUpForThemeIn [

	| e theme  |
	e := BlElement new.
	self assert: e toStyleStore themeClasses notNil.
	self assert: e toStyleStore themeClasses isEmpty.
	theme := ToRawTheme new.
	self deny: (e toStyleStore isSetUpForTheme: theme).
	e toStyleStore setUpForTheme: theme in: e.
	self assert: (e toStyleStore isSetUpForTheme: theme).
	self assert: e toStyleStore themeClasses size equals: 1.
	self assert: e toStyleStore themeClasses anyOne = ToRawTheme.
	e toStyleStore setUpForTheme: ToRawTheme new in: e.
	self assert: e toStyleStore themeClasses size equals: 1.
	self assert: e toStyleStore themeClasses anyOne = ToRawTheme.

]

{ #category : 'tests' }
ToStyleStoreTest >> testSetUpForThemeIn2 [

	| e theme skin space |
	e := BlElement new.
	space := BlSpace new.
	self assert: e toStyleStore themeClasses notNil.
	self assert: e toStyleStore themeClasses isEmpty.
	theme := ToRawTheme new.
	space root addChild: e.
	skin := theme newSkinFor: e.
	self assert: e toStyleStore themeClasses size equals: 1.
	self assert: e toStyleStore themeClasses anyOne = ToRawTheme
]

{ #category : 'tests' }
ToStyleStoreTest >> testStampIndex [

	| e dict |
	e := BlElement new.
	dict := e toStyleStore readOnlyStampIndex.
	self assert: dict notNil.

]

{ #category : 'tests' }
ToStyleStoreTest >> testStampNamed [

	| e p |
	e := BlElement new.
	e localToTheme: ToBeeLightTheme new.
	self
		should: [ e stampNamed: #color ]
		raise: ToElementPropertyNotFound.
	e withStamp: (p := (#color -> Color blue) asStyleStamp).
	self assert: (e stampNamed: #color) equals: p.
	e withStamp: (#background -> Color blue) asStyleStamp.
	e withStamp: (#layout -> BlLinearLayout horizontal) asStyleStamp.
	e withStamp: (p := (#something -> #something) asStyleStamp).
	self assert: (e stampNamed: #something) equals: p.
	self
		should: [ e stampNamed: #Color ]
		raise: ToElementPropertyNotFound
]

{ #category : 'tests' }
ToStyleStoreTest >> testStampNamedFrom [

	| e child space |
	e := BlElement new.
	child := BlElement new.
	e withStamp: (#color -> Color blue) asStyleStamp.
	e addChild: child.
	self
		assert: (child toStyleStore stampNamed: #color from: child)
		identicalTo: (e toStyleStore localStampNamed: #color).
	child withStamp: (#color -> Color red) asStyleStamp.
	self
		assert: (child toStyleStore stampNamed: #color from:  child)
		identicalTo: (child toStyleStore localStampNamed: #color).
	self
		should: [(child toStyleStore stampNamed: #something from: child)] raise: Error.
		
	space := BlSpace new.
	space root addChild: e.
	self
		should: [(child toStyleStore stampNamed: #something from: child)] raise: ToElementPropertyNotFound.

	
]

{ #category : 'tests' }
ToStyleStoreTest >> testStampValueFrom [

	| e p |
	e := BlElement new.
	e localToTheme: ToBeeLightTheme new.
	self
		should: [ e toStyleStore stampValue: #color from: e ]
		raise: ToElementPropertyNotFound.
	e withStamp: (p := (#color -> Color blue) asStyleStamp).
	self assert: (e toStyleStore stampValue: #color from: e) equals: p value.
	self assert: (e toStyleStore stampValue: #color from: e) equals: Color blue.
	e withStamp: (#background -> Color blue) asStyleStamp.
	e withStamp: (#layout -> BlLinearLayout horizontal) asStyleStamp.
	e withStamp: (#something -> #something) asStyleStamp.
	self assert: (e toStyleStore stampValue: #something from: e) equals: #something.
	self
		should: [ e toStyleStore stampValue: #Color from: e]
		raise: ToElementPropertyNotFound
]

{ #category : 'tests' }
ToStyleStoreTest >> testStyleSheet [

	self testStyleSheetIn 
]

{ #category : 'tests' }
ToStyleStoreTest >> testStyleSheetChainIn [

	| e child childchild childchildchild space |
	e := BlElement new.
	child := BlElement new.
	childchild := BlElement new.
	childchildchild := BlElement new.
	e addChild: child.
	child addChild: childchild.
	childchild addChild: childchildchild.
	" e is not attached -> # ( )"
	self
		assert:
		(childchildchild toStyleStore styleSheetChainIn: childchildchild)
		equals: #(  ).
	space := BlSpace new.
	space root addChild: e.
	" no styleSheet theme by default "
	self assert:
		(childchildchild toStyleStore styleSheetChainIn: childchildchild)
			isEmpty.
	space toTheme: ToStyleSheetTheme new.
	" no style sheet in theme "
	self assert:
		(childchildchild toStyleStore styleSheetChainIn: childchildchild)
			isEmpty.
	childchild styleSheet: ToStyleSheet new.
	self
		assert:
		(childchildchild toStyleStore styleSheetChainIn: childchildchild)
			size
		equals: 1.
	e styleSheet: ToStyleSheet new.
	self
		assert:
		(childchildchild toStyleStore styleSheetChainIn: childchildchild)
			size
		equals: 2.
	childchild toStyleStore styleSheet inherits: false.
	self
		assert:
		(childchildchild toStyleStore styleSheetChainIn: childchildchild)
			size
		equals: 1
]

{ #category : 'tests' }
ToStyleStoreTest >> testStyleSheetIn [

	| e |
	e := BlElement new.
	e styleSheet: ToStyleSheet new.
	self assert: e toStyleStore styleSheet notNil
]

{ #category : 'tests' }
ToStyleStoreTest >> testTextAttributesBuilder [

	| e  |
	e := BlElement new.
	self assert: (e toStyleStore textAttributesBuilder ) notNil
]

{ #category : 'tests' }
ToStyleStoreTest >> testThemeClasses [

	| e |
	e := BlElement new.
	self assert: e toStyleStore themeClasses notNil.
	self assert: e toStyleStore themeClasses isEmpty.
	e toStyleStore setUpForTheme: ToRawTheme new in: e.
	self assert: e toStyleStore themeClasses size equals: 1.
	self assert: e toStyleStore themeClasses anyOne = ToRawTheme
]

{ #category : 'tests' }
ToStyleStoreTest >> testWithAllStamps [

	| e |
	e := BlElement new.
	e withAllStamps: {  }.
	self assert: e toStyleStore readOnlyStampIndex notNil.
	e withAllStamps: { #color. #background }.
	self assert: e toStyleStore readOnlyStampIndex size equals: 2.
	self assert: (e hasStampNamed: #color).	
	self assert: (e hasStampNamed: #background).
	e withAllStamps: { #blob }.
	self assert: e toStyleStore readOnlyStampIndex size equals: 3.
	self assert: (e hasStampNamed: #color).	
	self assert: (e hasStampNamed: #background).
	self assert: (e hasStampNamed: #blob).


]

{ #category : 'tests' }
ToStyleStoreTest >> testWithStamp [

	| e |
	e := BlElement new.
	e withAllStamps: {  }.
	e withStamp: #color.
	e withStamp: #background.
	self assert: e toStyleStore readOnlyStampIndex size equals: 2.
	self assert: (e hasStampNamed: #color).	
	self assert: (e hasStampNamed: #background).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	e withStamp: #color.
	self assert: e toStyleStore readOnlyStampIndex size equals: 2.
	e withStamp: #blob.
	self assert: (e hasStampNamed: #color).	
	self assert: (e hasStampNamed: #background).
	self assert: (e hasStampNamed: #blob).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	self assert: (e stampValue: #blob).


]

{ #category : 'tests' }
ToStyleStoreTest >> testWithoutAllStamps [

	| e |
	e := BlElement new.
	e withStamp: (#color1 -> Color blue) asStyleStamp.
	e withStamp: (#color2 -> Color blue) asStyleStamp.
	self assert: e toStyleStore readOnlyStampIndex size equals: 2.
	e toStyleStore withoutAllStamps.
	self assert: e toStyleStore readOnlyStampIndex isEmpty.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore readOnlyStampIndex isEmpty
]

{ #category : 'tests' }
ToStyleStoreTest >> testWithoutStamp [

	| e |
	e := BlElement new.
	e localToTheme: ToBeeLightTheme new.
	e withAllStamps: {  }.
	e withStamp: #color.
	e withStamp: #background.
	self assert: e toStyleStore readOnlyStampIndex size equals: 2.
	self assert: (e hasStampNamed: #color).
	self assert: (e hasStampNamed: #background).
	self assert: (e hasStampNamed: #color).
	self assert: (e hasStampNamed: #background).
	e withoutStamp: #color.
	self assert: e toStyleStore readOnlyStampIndex size equals: 1.
	e withoutStamp: #blob.
	self deny: (e hasStampNamed: #color).
	self assert: (e hasStampNamed: #background).
	self deny: (e hasStampNamed: #blob).
	self
		should: [ e stampValue: #color ]
		raise: ToElementPropertyNotFound.
	self assert: (e stampValue: #background).
	self should: [ e stampValue: #blob ] raise: ToElementPropertyNotFound
]
