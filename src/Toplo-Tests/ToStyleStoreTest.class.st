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
