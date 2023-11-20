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
ToStyleStoreTest >> testAddStyleStamp [

	| e s s2 |
	e := BlElement new.
	e withStamp: (#color -> Color blue) asStyleStamp.
	self assert: (s := e toStyleStore localStampNamed: #color) notNil.
	self assert: (s isKindOf: ToStyleStamp).
	self assert: s name equals: #color.
	self assert: s value equals: Color blue.
	self assert: e toStyleStore stampIndex size equals: 1.
	e withStamp: (#color -> Color red) asStyleStamp.
	self assert: (s2 := e toStyleStore localStampNamed: #color) notNil.
	self assert: s2 name equals: #color.
	self assert: s2 value equals: Color red.
	self assert: s ~~ s2.
	self assert: e toStyleStore stampIndex size equals: 1
]

{ #category : 'tests' }
ToStyleStoreTest >> testHasStamp [

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
ToStyleStoreTest >> testLocalStyleStampIndex [

	| e dict |
	e := BlElement new.
	dict := e toStyleStore stampIndex.
	self assert: dict notNil.

]

{ #category : 'tests' }
ToStyleStoreTest >> testLocalStyleStampNamed [

	| e s |
	e := BlElement new.
	self assert: (e toStyleStore localStampNamed: #color) isNil.
	(e toStyleStore stampIndex)
		addProperty: #color asStyleStamp.
	s := e toStyleStore localStampNamed: #color.
	self assert: s notNil.
	self assert: (s isKindOf: ToStyleStamp).
	self assert: s name equals: #color.
	self assert: s value
]

{ #category : 'tests' }
ToStyleStoreTest >> testLookUpStyleStampNamed [

	| e child |
	e := BlElement new.
	child := BlElement new.
	e withStamp: (#color -> Color blue) asStyleStamp.
	self assert: e toStyleStore stampIndex size equals: 1.
	self
		assert: (e  stampNamed: #color)
		identicalTo: (e toStyleStore localStampNamed: #color).
	e addChild: child.
	self
		assert: (child  stampNamed: #color)
		identicalTo: (e toStyleStore localStampNamed: #color).
	child withStamp: (#color -> Color red) asStyleStamp.
	self
		assert: (child  stampNamed: #color)
		identicalTo: (child toStyleStore localStampNamed: #color)
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveStyleStampNamed [

	| e |
	e := BlElement new.
	e withStamp: (#color -> Color blue) asStyleStamp.
	self assert: e toStyleStore stampIndex size equals: 1.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore stampIndex isEmpty.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore stampIndex isEmpty
]

{ #category : 'tests' }
ToStyleStoreTest >> testRemoveStyleStampNamedIfAbsent [

	| e |
	e := BlElement new.
	e withStamp: (#color -> Color blue) asStyleStamp.
	self assert: e toStyleStore stampIndex size equals: 1.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore stampIndex isEmpty.
	e toStyleStore removeStampNamed: #color.
	e withStamp: (#color -> Color red) asStyleStamp.
	self assert: e toStyleStore stampIndex size equals: 1.
	e toStyleStore removeStampNamed: #blob .
	self assert: e toStyleStore stampIndex size equals: 1.
	e toStyleStore removeStampNamed: #color.
	self assert: e toStyleStore stampIndex isEmpty.


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
ToStyleStoreTest >> testStampValue [

	| e p |
	e := BlElement new.
	e localToTheme: ToBeeLightTheme new.
	self
		should: [ e stampValue: #color ]
		raise: ToElementPropertyNotFound.
	e withStamp: (p := (#color -> Color blue) asStyleStamp).
	self assert: (e stampValue: #color) equals: p value.
	self assert: (e stampValue: #color) equals: Color blue.
	e withStamp: (#background -> Color blue) asStyleStamp.
	e withStamp: (#layout -> BlLinearLayout horizontal) asStyleStamp.
	e withStamp: (#something -> #something) asStyleStamp.
	self assert: (e stampValue: #something) equals: #something.
	self
		should: [ e stampValue: #Color ]
		raise: ToElementPropertyNotFound
]

{ #category : 'tests' }
ToStyleStoreTest >> testWithAllStamps [

	| e |
	e := BlElement new.
	e withAllStamps: {  }.
	self assert: e toStyleStore stampIndex notNil.
	e withAllStamps: { #color. #background }.
	self assert: e toStyleStore stampIndex size equals: 2.
	self assert: (e hasStampNamed: #color).	
	self assert: (e hasStampNamed: #background).
	e withAllStamps: { #blob }.
	self assert: e toStyleStore stampIndex size equals: 3.
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
	self assert: e toStyleStore stampIndex size equals: 2.
	self assert: (e hasStampNamed: #color).	
	self assert: (e hasStampNamed: #background).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	e withStamp: #color.
	self assert: e toStyleStore stampIndex size equals: 2.
	e withStamp: #blob.
	self assert: (e hasStampNamed: #color).	
	self assert: (e hasStampNamed: #background).
	self assert: (e hasStampNamed: #blob).
	self assert: (e stampValue: #color).	
	self assert: (e stampValue: #background).
	self assert: (e stampValue: #blob).


]

{ #category : 'tests' }
ToStyleStoreTest >> testWithoutStamp [

	| e |
	e := BlElement new.
	e localToTheme: ToBeeLightTheme new.
	e withAllStamps: {  }.
	e withStamp: #color.
	e withStamp: #background.
	self assert: e toStyleStore stampIndex size equals: 2.
	self assert: (e hasStampNamed: #color).
	self assert: (e hasStampNamed: #background).
	self assert: (e hasStampNamed: #color).
	self assert: (e hasStampNamed: #background).
	e withoutStamp: #color.
	self assert: e toStyleStore stampIndex size equals: 1.
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
