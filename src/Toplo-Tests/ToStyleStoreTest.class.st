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
ToStyleStoreTest >> testAddTokenProperty [

	| e s s2 |
	e := BlElement new.
	e toStyleStore addTokenProperty: (#color -> Color blue) asTokenProperty.
	self assert: (s := e toStyleStore localTokenPropertyNamed: #color) notNil.
	self assert: (s isKindOf: ToTokenProperty).
	self assert: s name equals: #color.
	self assert: s value equals: Color blue.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e withStamp: (#color -> Color red) asTokenProperty.
	self assert: (s2 := e toStyleStore localTokenPropertyNamed: #color) notNil.
	self assert: s2 name equals: #color.
	self assert: s2 value equals: Color red.
	self assert: s ~~ s2.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1
]

{ #category : 'tests' }
ToStyleStoreTest >> testHasTokenPropertyNamed [

	| e |
	e := BlElement new.
	self deny: (e hasTokenPropertyNamed: #color).
	e withStamp: (#color -> Color blue) asTokenProperty.
	self assert: (e hasTokenPropertyNamed: #color).
	e withStamp: (#background -> Color blue) asTokenProperty.
	e withStamp: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	e withStamp: (#something -> #something) asTokenProperty.
	self assert: (e hasTokenPropertyNamed: #something).
	self assert: (e hasTokenPropertyNamed: #color).

]

{ #category : 'tests' }
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

{ #category : 'tests' }
ToStyleStoreTest >> testLookUpTokenPropertyNamedFrom [

	| e child |
	e := BlElement new.
	child := BlElement new.
	e withStamp: (#color -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	self
		assert: (e toStyleStore lookUpTokenPropertyNamed: #color from: e)
		identicalTo: (e toStyleStore localTokenPropertyNamed: #color).
	e addChild: child.
	self
		assert: (child toStyleStore lookUpTokenPropertyNamed: #color from: child)
		identicalTo: (e toStyleStore localTokenPropertyNamed: #color).
	child withStamp: (#color -> Color red) asTokenProperty.
	self
		assert: (child toStyleStore lookUpTokenPropertyNamed: #color from: child)
		identicalTo: (child toStyleStore localTokenPropertyNamed: #color).
	self
		assert: (child toStyleStore lookUpTokenPropertyNamed: #something from: child) isNil
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed [

	| e |
	e := BlElement new.
	e withStamp: (#color1 -> Color blue) asTokenProperty.
	e withStamp: (#color2 -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	e toStyleStore removeTokenPropertyNamed: #color1.
	self assert: e toStyleStore tokenPropertyIndex size = 1.
	e toStyleStore removeTokenPropertyNamed: #color2.
	self assert: e toStyleStore tokenPropertyIndex isEmpty
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed2 [

	| e |
	e := BlElement new.
	e withStamp: (#color -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed3 [

	| e |
	e := BlElement new.
	e withStamp: (#color -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed4 [

	| e |
	e := BlElement new.
	e withStamp: (#color -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty.
	e toStyleStore removeTokenPropertyNamed: #color.
	e withStamp: (#color -> Color red) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #blob .
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty.


]

{ #category : 'tests' }
ToStyleStoreTest >> testStampNamed [

	| e p |
	e := BlElement new.
	self
		should: [ e stampNamed: #color ]
		raise: ToElementPropertyNotFound.
	e withStamp: (p := (#color -> Color blue) asTokenProperty).
	self assert: (e stampNamed: #color) equals: p.
	e withStamp: (#background -> Color blue) asTokenProperty.
	e withStamp: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	e withStamp: (p := (#something -> #something) asTokenProperty).
	self assert: (e stampNamed: #something) equals: p.
	self
		should: [ e stampNamed: #Color ]
		raise: ToElementPropertyNotFound
]

{ #category : 'tests' }
ToStyleStoreTest >> testTokenPropertyIndex [

	| e dict |
	e := BlElement new.
	dict := e toStyleStore tokenPropertyIndex.
	self assert: dict notNil.

]

{ #category : 'tests' }
ToStyleStoreTest >> testTokenPropertyNamedFrom [

	| e child space |
	e := BlElement new.
	child := BlElement new.
	e withStamp: (#color -> Color blue) asTokenProperty.
	e addChild: child.
	self
		assert: (child toStyleStore tokenPropertyNamed: #color from: child)
		identicalTo: (e toStyleStore localTokenPropertyNamed: #color).
	child withStamp: (#color -> Color red) asTokenProperty.
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

{ #category : 'tests' }
ToStyleStoreTest >> testTokenPropertyValueFrom [

	| e p |
	e := BlElement new.
	self
		should: [ e toStyleStore tokenPropertyValue: #color from: e ]
		raise: ToElementPropertyNotFound.
	e withStamp: (p := (#color -> Color blue) asTokenProperty).
	self assert: (e toStyleStore tokenPropertyValue: #color from: e) equals: p value.
	self assert: (e toStyleStore tokenPropertyValue: #color from: e) equals: Color blue.
	e withStamp: (#background -> Color blue) asTokenProperty.
	e withStamp: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	e withStamp: (#something -> #something) asTokenProperty.
	self assert: (e toStyleStore tokenPropertyValue: #something from: e) equals: #something.
	self
		should: [ e toStyleStore tokenPropertyValue: #Color from: e]
		raise: ToElementPropertyNotFound
]

{ #category : 'tests' }
ToStyleStoreTest >> testWithAllStamps [

	| e |
	e := BlElement new.
	e withAllStamps: {  }.
	self assert: e toStyleStore tokenPropertyIndex notNil.
	e withAllStamps: { #color. #background }.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	self assert: (e hasTokenPropertyNamed: #color).	
	self assert: (e hasTokenPropertyNamed: #background).
	e withAllStamps: { #blob }.
	self assert: e toStyleStore tokenPropertyIndex size equals: 3.
	self assert: (e hasTokenPropertyNamed: #color).	
	self assert: (e hasTokenPropertyNamed: #background).
	self assert: (e hasTokenPropertyNamed: #blob).


]

{ #category : 'tests' }
ToStyleStoreTest >> testWithStamp [

	| e |
	e := BlElement new.
	e withAllStamps: {  }.
	e withStamp: #color.
	e withStamp: #background.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	self assert: (e hasTokenPropertyNamed: #color).	
	self assert: (e hasTokenPropertyNamed: #background).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	e withStamp: #color.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	e withStamp: #blob.
	self assert: (e hasTokenPropertyNamed: #color).	
	self assert: (e hasTokenPropertyNamed: #background).
	self assert: (e hasTokenPropertyNamed: #blob).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	self assert: (e stampValue: #blob).


]

{ #category : 'tests' }
ToStyleStoreTest >> testWithoutAllStamps [

	| e |
	e := BlElement new.
	e withStamp: (#color1 -> Color blue) asTokenProperty.
	e withStamp: (#color2 -> Color blue) asTokenProperty.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	e toStyleStore withoutAllStamps.
	self assert: e toStyleStore tokenPropertyIndex isEmpty.
	e toStyleStore removeTokenPropertyNamed: #color.
	self assert: e toStyleStore tokenPropertyIndex isEmpty
]

{ #category : 'tests' }
ToStyleStoreTest >> testWithoutStamp [

	| e |
	e := BlElement new.
	e withAllStamps: {  }.
	e withStamp: #color.
	e withStamp: #background.
	self assert: e toStyleStore tokenPropertyIndex size equals: 2.
	self assert: (e hasTokenPropertyNamed: #color).
	self assert: (e hasTokenPropertyNamed: #background).
	self assert: (e hasTokenPropertyNamed: #color).
	self assert: (e hasTokenPropertyNamed: #background).
	e withoutStamp: #color.
	self assert: e toStyleStore tokenPropertyIndex size equals: 1.
	e withoutStamp: #blob.
	self deny: (e hasTokenPropertyNamed: #color).
	self assert: (e hasTokenPropertyNamed: #background).
	self deny: (e hasTokenPropertyNamed: #blob).
	self
		should: [ e stampValue: #color ]
		raise: ToElementPropertyNotFound.
	self assert: (e stampValue: #background).
	self should: [ e stampValue: #blob ] raise: ToElementPropertyNotFound
]
