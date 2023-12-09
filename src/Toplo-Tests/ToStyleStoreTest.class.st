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

{ #category : 'stamps' }
ToStyleStoreTest >> testAddAllStamps [

	| e |
	e := BlElement new.
	e toStyleStore addAllStamps: {  }.
	self assert: e toStyleStore allStamps isEmpty.
	e toStyleStore addAllStamps: { #color. #background }.
	self assert: e toStyleStore allStamps size equals: 2.
	self assert: (e toStyleStore hasStamp: #color).	
	self assert: (e toStyleStore hasStamp: #background).
	e toStyleStore addAllStamps: { #blob }.
	self assert: e toStyleStore allStamps size equals: 3.
	self assert: (e toStyleStore hasStamp: #color).	
	self assert: (e toStyleStore hasStamp: #background).
	self assert: (e toStyleStore hasStamp: #blob).


]

{ #category : 'token properties' }
ToStyleStoreTest >> testAddAllTokenProperties [

	| e s |
	e := BlElement new.
	e toStyleStore addAllTokenProperties: {
			(#color1 -> Color blue) asTokenProperty.
			(#color2 -> Color red) asTokenProperty }.
	self assert:
		(s := e toStyleStore localTokenPropertyNamed: #color1) notNil.
	self assert:
		(s := e toStyleStore localTokenPropertyNamed: #color2) notNil.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	e toStyleStore addAllTokenProperties: {
			(#color1 -> Color white) asTokenProperty.
			(#color2 -> Color yellow) asTokenProperty }.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	self assert: (e toStyleStore tokenPropertyNamed: #color1) value equals: Color white.
	self assert: (e toStyleStore tokenPropertyNamed: #color2) value equals: Color yellow.

]

{ #category : 'stamps' }
ToStyleStoreTest >> testAddStamp [

	| e |
	e := BlElement new.
	e addAllStamps: {  }.
	e addStamp: #color.
	e addStamp: #background.
	self assert: e toStyleStore allStamps size equals: 2.
	self assert: (e toStyleStore hasStamp: #color).	
	self assert: (e toStyleStore hasStamp: #background).
	e addStamp: #color.
	self assert: e toStyleStore allStamps size equals: 2.
	e addStamp: #blob.
	self assert: (e toStyleStore hasStamp: #color).	
	self assert: (e toStyleStore hasStamp: #background).
	self assert: (e toStyleStore hasStamp: #blob)

]

{ #category : 'token properties' }
ToStyleStoreTest >> testAddTokenProperty [

	| e s s2 |
	e := BlElement new.
	e toStyleStore addTokenProperty: (#color -> Color blue) asTokenProperty.
	self assert: (s := e toStyleStore localTokenPropertyNamed: #color) notNil.
	self assert: (s isKindOf: ToTokenProperty).
	self assert: s name equals: #color.
	self assert: s value equals: Color blue.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore addTokenProperty: (#color -> Color red) asTokenProperty.
	self assert: (s2 := e toStyleStore localTokenPropertyNamed: #color) notNil.
	self assert: s2 name equals: #color.
	self assert: s2 value equals: Color red.
	self assert: s ~~ s2.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1
]

{ #category : 'stamps' }
ToStyleStoreTest >> testAllStamps [

	| e |
	e := BlElement new.
	e toStyleStore addAllStamps: {  }.
	self assert: e toStyleStore allStamps isEmpty.
	e toStyleStore addAllStamps: { #color. #background }.
	self assert: e toStyleStore allStamps size equals: 2.
	self assert: (e toStyleStore hasStamp: #color).	
	self assert: (e toStyleStore hasStamp: #background)
]

{ #category : 'stamps' }
ToStyleStoreTest >> testHasAllStamps [

	| e |
	e := BlElement new.
	e toStyleStore addAllStamps: {  }.
	self assert: e toStyleStore allStamps isEmpty.
	e toStyleStore addAllStamps: { #color. #background }.
	self assert: (e toStyleStore hasAllStamps: { #color. #background }).	
	self deny: (e toStyleStore hasAllStamps: { #something. #background }).	

]

{ #category : 'stamps' }
ToStyleStoreTest >> testHasStamp [

	| e |
	e := BlElement new.
	e toStyleStore addAllStamps: {  }.
	self assert: e toStyleStore allStamps isEmpty.
	e toStyleStore addAllStamps: { #color. #background }.
	self assert: (e toStyleStore hasStamp: #color ).	
	self deny: (e toStyleStore hasStamp: #something ).	

]

{ #category : 'token properties' }
ToStyleStoreTest >> testHasTokenPropertyNamed [

	| e |
	e := BlElement new.
	self deny: (e toStyleStore hasTokenPropertyNamed: #color).
	e toStyleStore addTokenProperty: (#color -> Color blue) asTokenProperty.
	self assert: (e toStyleStore hasTokenPropertyNamed: #color).
	e toStyleStore addTokenProperty: (#background -> Color blue) asTokenProperty.
	e toStyleStore addTokenProperty: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	e toStyleStore addTokenProperty: (#something -> #something) asTokenProperty.
	self assert: (e toStyleStore hasTokenPropertyNamed: #something).
	self assert: (e toStyleStore hasTokenPropertyNamed: #color)
]

{ #category : 'token properties' }
ToStyleStoreTest >> testLocalTokenPropertyNamed [

	| e s |
	e := BlElement new.
	self assert: (e toStyleStore localTokenPropertyNamed: #color) isNil.
	(e toStyleStore tokenPropertyIndex)
		addProperty: #color asTokenProperty.
	s := e toStyleStore localTokenPropertyNamed: #color.
	self assert: s notNil.
	self assert: (s isKindOf: ToTokenProperty).
	self assert: s name equals: #color.
	self assert: s value
]

{ #category : 'token properties' }
ToStyleStoreTest >> testLookUpTokenPropertyNamedFrom [

	| e child |
	e := BlElement new.
	child := BlElement new.
	e toStyleStore addTokenProperty: (#color -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	self
		assert: (e toStyleStore lookUpTokenPropertyNamed: #color from: e)
		identicalTo: (e toStyleStore localTokenPropertyNamed: #color).
	e addChild: child.
	self
		assert: (child toStyleStore lookUpTokenPropertyNamed: #color from: child)
		identicalTo: (e toStyleStore localTokenPropertyNamed: #color).
	child toStyleStore addTokenProperty: (#color -> Color red) asTokenProperty.
	self
		assert: (child toStyleStore lookUpTokenPropertyNamed: #color from: child)
		identicalTo: (child toStyleStore localTokenPropertyNamed: #color).
	self
		assert: (child toStyleStore lookUpTokenPropertyNamed: #something from: child) isNil
]

{ #category : 'stamps' }
ToStyleStoreTest >> testRemoveAllStamps [

	| e |
	e := BlElement new.
	e toStyleStore addStamp: (#color1).
	e toStyleStore addStamp: (#color2 ).
	self assert: e toStyleStore allStamps size equals: 2.
	e toStyleStore removeAllStamps.
	self assert: e toStyleStore allStamps isEmpty.
	e toStyleStore removeStamp: #color.
	self assert: e toStyleStore allStamps isEmpty
]

{ #category : 'stamps' }
ToStyleStoreTest >> testRemoveAllStamps2 [

	| e |
	e := BlElement new.
	e toStyleStore addStamp: (#color1).
	e toStyleStore addStamp: (#color2 ).
	e toStyleStore addStamp: (#color3).
	e toStyleStore addStamp: (#color4 ).
	self assert: e toStyleStore allStamps size equals: 4.
	e toStyleStore removeAllStamps: { #color1. #color3 }.
	self assert: e toStyleStore allStamps asSet equals: #(#color2 #color4) asSet
]

{ #category : 'stamps' }
ToStyleStoreTest >> testRemoveStamp [

	| e |
	e := BlElement new.
	e toStyleStore addAllStamps: {  }.
	e toStyleStore addStamp: #color.
	e toStyleStore addStamp: #background.
	self assert: e toStyleStore allStamps size equals: 2.
	self assert: (e toStyleStore hasStamp: #color).
	self assert: (e toStyleStore hasStamp: #background).
	e toStyleStore removeStamp: #color.
	self assert: e toStyleStore allStamps size equals: 1.
	e toStyleStore removeStamp: #blob.
	self deny: (e toStyleStore hasStamp: #color).
	self assert: (e toStyleStore hasStamp: #background)
]

{ #category : 'token properties' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed [

	| e |
	e := BlElement new.
	e toStyleStore addTokenProperty: (#color1 -> Color blue) asTokenProperty.
	e toStyleStore addTokenProperty: (#color2 -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	e toStyleStore removeTokenPropertyNamed: #color1.
	self assert: e toStyleStore tokenPropertyIndex size = 1.
	e toStyleStore removeTokenPropertyNamed: #color2.
	self assert: e toStyleStore tokenPropertyIndex isEmpty
]

{ #category : 'token properties' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed2 [

	| e |
	e := BlElement new.
	e toStyleStore addTokenProperty: (#color -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty
]

{ #category : 'token properties' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed4 [

	| e |
	e := BlElement new.
	e toStyleStore addTokenProperty: (#color -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty.
	e toStyleStore removeTokenPropertyNamed: #color.
	e toStyleStore addTokenProperty: (#color -> Color red) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #blob .
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty.


]

{ #category : 'stamps' }
ToStyleStoreTest >> testStampPropertyNamed [

	| e |
	e := BlElement new.
	e toStyleStore addStamp: #color.
	e toStyleStore addStamp: #background.
	self assert: ((e toStyleStore stampPropertyNamed: #color) isKindOf: ToStampProperty).
	self should: [ e e toStyleStore stampPropertyNamed: #something ] raise: Error
]

{ #category : 'stamps' }
ToStyleStoreTest >> testStampValue [

	| e |
	e := BlElement new.
	e toStyleStore addStamp: #color value: Color blue.
	e toStyleStore addStamp: #background value: Color red.
	e toStyleStore addStamp: #primary.
	self assert: (e toStyleStore stampValue: #color) equals: Color blue.
	self assert: (e toStyleStore stampValue: #background) equals: Color red.
	self assert: (e toStyleStore stampValue: #primary) equals: true.
	self should: [ e toStyleStore stampValue: #something ] raise: Error
]

{ #category : 'token properties' }
ToStyleStoreTest >> testTokenPropertyIndex [

	| e dict |
	e := BlElement new.
	dict := e toStyleStore tokenPropertyIndex.
	self assert: dict notNil.

]

{ #category : 'token properties' }
ToStyleStoreTest >> testTokenPropertyNamed [

	| e p |
	e := BlElement new.
	self assert: (e toStyleStore tokenPropertyNamed: #color) isNil.
	e toStyleStore addTokenProperty: (p := (#color -> Color blue) asTokenProperty).
	self assert: (e toStyleStore tokenPropertyNamed: #color) equals: p.
	e toStyleStore addTokenProperty: (#background -> Color blue) asTokenProperty.
	e toStyleStore addTokenProperty: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	e toStyleStore addTokenProperty: (p := (#something -> #something) asTokenProperty).
	self assert: (e toStyleStore tokenPropertyNamed: #something) equals: p.
	self assert: (e toStyleStore tokenPropertyNamed: #color) notNil
]

{ #category : 'token properties' }
ToStyleStoreTest >> testTokenPropertyNamedFrom [

	| e child space |
	e := BlElement new.
	child := BlElement new.
	e toStyleStore addTokenProperty: (#color -> Color blue) asTokenProperty.
	e addChild: child.
	self
		assert: (child toStyleStore tokenPropertyNamed: #color from: child)
		identicalTo: (e toStyleStore localTokenPropertyNamed: #color).
	child toStyleStore addTokenProperty: (#color -> Color red) asTokenProperty.
	self
		assert: (child toStyleStore tokenPropertyNamed: #color from:  child)
		identicalTo: (child toStyleStore localTokenPropertyNamed: #color).
	self
		should: [(child toStyleStore tokenPropertyNamed: #something from: child)] raise: Error.
		
	space := BlSpace new.
	space root addChild: e.
	self
		should: [(child toStyleStore tokenPropertyNamed: #something from: child)] raise: ToElementPropertyNotFound.

	
]

{ #category : 'token properties' }
ToStyleStoreTest >> testTokenPropertyNamedFromBeforeSpaceShownRaiseError [

	| e space |	
	space := BlSpace new.
	e := ToElement new.
	space root addChild: e.
	self should: [e tokenValueNamed: #'background-color'] raise: ToElementPropertyNotFound
]

{ #category : 'token properties' }
ToStyleStoreTest >> testTokenPropertyNamedFromBeforeSpaceShownRaiseError2 [

	| e space goneHere |
	space := BlSpace new.
	e := ToElement new.
	e defaultSkin: ToSpaceRootSkin new.
	space root addChild: e.
	" since the space skin phases are not not installed by the the skin phase manager,
	the theme is not installed an then, installing a skin that requires a property fails "
	self flag: 'the next statement make the test fail because the skin of e is installed (and then a new skinInstaller will not change the skin)'.
	"self should: [space applyAllSkinInstallers] raise: ToElementPropertyNotFound."
	self assert: e background isTransparent.
	goneHere := false.
	space when: ToSpaceSkinPhasesStarted do: [
		goneHere := true.
		self assert: e installedSkin isNil.
		self assert: e skinInstaller notNil.
		self assert: (e tokenValueNamed: #'background-color') notNil.
		e applySkinInstaller.
		self deny: e background isTransparent ].
	space startSkinPhases.
	self assert: goneHere
]

{ #category : 'token properties' }
ToStyleStoreTest >> testTokenPropertyNamedRequiresSpaceSkinPhasesStarted [

	| e space goneHere |
	space := BlSpace new.
	e := ToElement new.
	e defaultSkin: ToSpaceRootSkin new.
	space root addChild: e.
	self assert: e background isTransparent.
	goneHere := false.
	space when: ToSpaceSkinPhasesStarted do: [
		goneHere := true.
		e applySkinInstaller.
		self deny: e background isTransparent ].
	space startSkinPhases.
	self assert: goneHere
]

{ #category : 'token properties' }
ToStyleStoreTest >> testTokenPropertyValueFrom [

	| e p |
	e := BlElement new.
	self assert: (e toStyleStore localTokenPropertyNamed: #color) isNil.
	e toStyleStore addTokenProperty: (p := (#color -> Color blue) asTokenProperty).
	self assert: (e toStyleStore tokenPropertyValue: #color from: e) equals: p value.
	self assert: (e toStyleStore tokenPropertyValue: #color from: e) equals: Color blue.
	e toStyleStore addTokenProperty: (#background -> Color blue) asTokenProperty.
	e toStyleStore addTokenProperty: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	e toStyleStore addTokenProperty: (#something -> #something) asTokenProperty.
	self assert: (e toStyleStore tokenPropertyValue: #something from: e) equals: #something.

]
