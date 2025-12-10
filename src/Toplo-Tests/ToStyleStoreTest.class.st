"
A ToStyleSheetManagerTest is a test class for testing the behavior of ToStyleSheetManager
"
Class {
	#name : #ToStyleStoreTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #stamps }
ToStyleStoreTest >> testAddAllStamps [

	| e |
	e := BlElement new.
	e addAllStamps: {  }.
	self assert: e allStamps isEmpty.
	e addAllStamps: { #color. #background }.
	self assert: e allStamps size equals: 2.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	e addAllStamps: { #blob }.
	self assert: e allStamps size equals: 3.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	self assert: (e hasStamp: #blob).


]

{ #category : #'token properties' }
ToStyleStoreTest >> testAddAllTokenProperties [

	| e s |
	e := BlElement new.
	e addAllTokenProperties: {
			(#color1 -> Color blue) asTokenProperty.
			(#color2 -> Color red) asTokenProperty }.
	self assert:
		(s := e tokenPropertyMap propertyNamed: #color1) notNil.
	self assert:
		(s := e tokenPropertyMap propertyNamed: #color2) notNil.
	self assert: e tokenPropertyMap size equals: 2.
	e tokenPropertyMap addAllProperties: {
			(#color1 -> Color white) asTokenProperty.
			(#color2 -> Color yellow) asTokenProperty }.
	self assert: e  tokenPropertyMap size equals: 2.
	self assert: (e tokenPropertyMap propertyNamed: #color1) value equals: Color white.
	self assert: (e tokenPropertyMap propertyNamed: #color2) value equals: Color yellow.

]

{ #category : #stamps }
ToStyleStoreTest >> testAddStamp [

	| e |
	e := BlElement new.
	e addAllStamps: {  }.
	e addStamp: #color.
	e addStamp: #background.
	self assert: e allStamps size equals: 2.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	e addStamp: #color.
	self assert: e allStamps size equals: 2.
	e addStamp: #blob.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background).
	self assert: (e hasStamp: #blob)

]

{ #category : #'token properties' }
ToStyleStoreTest >> testAddTokenProperty [

	| e s s2 |
	e := BlElement new.
	e ensuredTokenPropertyMap addProperty: (#color -> Color blue) asTokenProperty.
	self assert: (s := e tokenPropertyMap propertyNamed: #color) notNil.
	self assert: (s isKindOf: ToTokenProperty).
	self assert: s name equals: #color.
	self assert: s value equals: Color blue.
	self assert: e tokenPropertyMap size equals: 1.
	e tokenPropertyMap addProperty: (#color -> Color red) asTokenProperty.
	self assert: (s2 := e tokenPropertyMap propertyNamed: #color) notNil.
	self assert: s2 name equals: #color.
	self assert: s2 value equals: Color red.
	self assert: s ~~ s2.
	self assert: e tokenPropertyMap size equals: 1
]

{ #category : #stamps }
ToStyleStoreTest >> testAllStamps [

	| e |
	e := BlElement new.
	e addAllStamps: {  }.
	self assert: e allStamps isEmpty.
	e addAllStamps: { #color. #background }.
	self assert: e allStamps size equals: 2.
	self assert: (e hasStamp: #color).	
	self assert: (e hasStamp: #background)
]

{ #category : #'token properties' }
ToStyleStoreTest >> testEnsuredStampMap [

	| e map |
	e := BlElement new.
	self assert: e stampMap  isNil.
	map := e ensuredStampMap.
	self assert: map notNil.
	self assert: map identicalTo: e stampMap
]

{ #category : #'token properties' }
ToStyleStoreTest >> testEnsuredTokenPropertyMap [

	| e map |
	e := BlElement new.
	self assert: e tokenPropertyMap isNil.
	map := e ensuredTokenPropertyMap.
	self assert: map notNil.
	self assert: map identicalTo: e tokenPropertyMap
]

{ #category : #stamps }
ToStyleStoreTest >> testHasAllStamps [

	| e |
	e := BlElement new.
	e addAllStamps: {  }.
	self assert: e allStamps isEmpty.
	e addAllStamps: { #color. #background }.
	self assert: (e hasAllStamps: { #color. #background }).	
	self deny: (e hasAllStamps: { #something. #background }).	

]

{ #category : #stamps }
ToStyleStoreTest >> testHasStamp [

	| e |
	e := BlElement new.
	e addAllStamps: {  }.
	self assert: e allStamps isEmpty.
	e addAllStamps: { #color. #background }.
	self assert: (e hasStamp: #color ).	
	self deny: (e hasStamp: #something ).	

]

{ #category : #'token properties' }
ToStyleStoreTest >> testHasTokenPropertyNamed [

	| e |
	e := BlElement new.
	self deny: (e ensuredTokenPropertyMap hasPropertyNamed: #color).
	e tokenPropertyMap addProperty: (#color -> Color blue) asTokenProperty.
	self assert: (e tokenPropertyMap hasPropertyNamed: #color).
	e tokenPropertyMap addProperty: (#background -> Color blue) asTokenProperty.
	e tokenPropertyMap addProperty: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	e tokenPropertyMap addProperty: (#something -> #something) asTokenProperty.
	self assert: (e tokenPropertyMap hasPropertyNamed: #something).
	self assert: (e tokenPropertyMap hasPropertyNamed: #color)
]

{ #category : #'token properties' }
ToStyleStoreTest >> testLocalTokenPropertyNamed [

	| e s |
	e := BlElement new.
	self assert: (e ensuredTokenPropertyMap propertyNamed: #color) isNil.
	(e ensuredTokenPropertyMap)
		addProperty: #color asTokenProperty.
	s := e tokenPropertyMap propertyNamed: #color.
	self assert: s notNil.
	self assert: (s isKindOf: ToTokenProperty).
	self assert: s name equals: #color.
	self assert: s value
]

{ #category : #stamps }
ToStyleStoreTest >> testRemoveAllStamps [

	| e |
	e := BlElement new.
	e addStamp: (#color1).
	e addStamp: (#color2 ).
	self assert: e allStamps size equals: 2.
	e removeAllStamps.
	self assert: e allStamps isEmpty.
	e removeStamp: #color.
	self assert: e allStamps isEmpty
]

{ #category : #stamps }
ToStyleStoreTest >> testRemoveAllStamps2 [

	| e |
	e := BlElement new.
	e addStamp: (#color1).
	e addStamp: (#color2 ).
	e addStamp: (#color3).
	e addStamp: (#color4 ).
	self assert: e allStamps size equals: 4.
	e removeAllStamps: { #color1. #color3 }.
	self assert: e allStamps asSet equals: #(#color2 #color4) asSet
]

{ #category : #stamps }
ToStyleStoreTest >> testRemoveStamp [

	| e |
	e := BlElement new.
	e addAllStamps: {  }.
	e  addStamp: #color.
	e  addStamp: #background.
	self assert: e  allStamps size equals: 2.
	self assert: (e  hasStamp: #color).
	self assert: (e  hasStamp: #background).
	e  removeStamp: #color.
	self assert: e  allStamps size equals: 1.
	e  removeStamp: #blob.
	self deny: (e  hasStamp: #color).
	self assert: (e  hasStamp: #background)
]

{ #category : #'token properties' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed [

	| e |
	e := BlElement new.
	e ensuredTokenPropertyMap addProperty:
		(#color1 -> Color blue) asTokenProperty.
	e tokenPropertyMap addProperty:
		(#color2 -> Color blue) asTokenProperty.
	self assert: e tokenPropertyMap size equals: 2.
	e tokenPropertyMap removePropertyNamed: #color1.
	self assert: e tokenPropertyMap size equals: 1.
	e tokenPropertyMap removePropertyNamed: #color2.
	self assert: e tokenPropertyMap isEmpty
]

{ #category : #'token properties' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed2 [

	| e |
	e := BlElement new.
	e ensuredTokenPropertyMap addProperty: (#color -> Color blue) asTokenProperty.
	self assert: e tokenPropertyMap size equals: 1.
	e tokenPropertyMap removePropertyNamed: #color.
	self assert: e tokenPropertyMap isEmpty.
	e tokenPropertyMap removePropertyNamed: #color.
	self assert: e tokenPropertyMap isEmpty
]

{ #category : #'token properties' }
ToStyleStoreTest >> testRemoveTokenPropertyNamed4 [

	| e |
	e := BlElement new.
	e ensuredTokenPropertyMap addProperty: (#color -> Color blue) asTokenProperty.
	self assert: e tokenPropertyMap size equals: 1.
	e tokenPropertyMap removePropertyNamed: #color.
	self assert: e tokenPropertyMap isEmpty.
	e tokenPropertyMap removePropertyNamed: #color.
	e tokenPropertyMap addProperty: (#color -> Color red) asTokenProperty.
	self assert: e tokenPropertyMap size equals: 1.
	e tokenPropertyMap removePropertyNamed: #blob .
	self assert: e tokenPropertyMap size equals: 1.
	e tokenPropertyMap removePropertyNamed: #color.
	self assert: e tokenPropertyMap isEmpty.


]

{ #category : #'token properties' }
ToStyleStoreTest >> testStampMap [

	| e |
	e := BlElement new.
	self assert: e stampMap  isNil
]

{ #category : #stamps }
ToStyleStoreTest >> testStampPropertyNamed [

	| e |
	e := BlElement new.
	e addStamp: #color.
	e  addStamp: #background.
	self assert: ((e stampMap propertyNamed: #color) isKindOf: ToStampProperty).
	self should: [ e stampMap propertyNamed: #something ifAbsent: [ Error new signal ]] raise: Error
]

{ #category : #stamps }
ToStyleStoreTest >> testStampValue [

	| e |
	e := BlElement new.
	e addStamp: #color withValue: Color blue.
	e addStamp: #background withValue: Color red.
	e addStamp: #primary.
	self assert: (e stampValue: #color) equals: Color blue.
	self assert: (e stampValue: #background) equals: Color red.
	self assert: (e stampValue: #primary).
	self should: [ e stampValue: #something ] raise: Error
]

{ #category : #'token properties' }
ToStyleStoreTest >> testTokenPropertyMap [

	| e dict |
	e := BlElement new.
	dict := e tokenPropertyMap.
	self assert: dict isNil.

]

{ #category : #'token properties' }
ToStyleStoreTest >> testTokenPropertyNamed [

	| e p |
	e := BlElement new.
	self assert: (e tokenPropertyMap) isNil.
	e ensuredTokenPropertyMap addProperty: (p := (#color -> Color blue) asTokenProperty).
	self assert: (e tokenPropertyMap propertyNamed: #color) equals: p.
	e tokenPropertyMap addProperty: (#background -> Color blue) asTokenProperty.
	e tokenPropertyMap addProperty: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	e tokenPropertyMap addProperty: (p := (#something -> #something) asTokenProperty).
	self assert: (e tokenPropertyMap propertyNamed: #something) equals: p.
	self assert: (e tokenPropertyMap propertyNamed: #color) notNil
]

{ #category : #'token properties' }
ToStyleStoreTest >> testTokenPropertyNamedFromBeforeSpaceShown [

	| e space |	
	space := BlSpace new.
	e := ToElement new.
	space root addChild: e.
	e valueOfTokenNamed: #'background-color'
]

{ #category : #'token properties' }
ToStyleStoreTest >> testTokenPropertyNamedFromBeforeSpaceShown2 [

	| e space goneHere |
	space := BlSpace new.
	goneHere := false.
	e := ToElement new.
	space addEventHandler: (BlEventHandler
			 on: ToSpacePhasesStarted
			 do: [
				 goneHere := true.
				 self assert:
					 (e skinManager ifNotNil: [ :sm | sm installedSkin ]) notNil.
				 self deny: e skinManager newSkinRequested.
				 self assert: (e valueOfTokenNamed: #'background-color') notNil.
				 e skinManager installNewSkinIn: e.
				 self deny: e background isTransparent ]).

	e defaultSkin: ToBackgroundColorSkinForTest new.
	space root addChild: e.
	" since the space skin phases are not not installed by the the skin phase manager,
	the theme is not installed an then, installing a skin that requires a property fails "
	self deny: e background isTransparent.
	self assert: goneHere
]

{ #category : #'token properties' }
ToStyleStoreTest >> testTokenPropertyNamedRequiresSpaceSkinPhasesStarted [

	| e space goneHere |
	space := BlSpace new.
	e := ToElement new.
	goneHere := false.
	space addEventHandler: (BlEventHandler
			 on: ToSpacePhasesStarted
			 do: [
				 goneHere := true.
				 e skinManager installNewSkinIn: e.
				 self deny: e background isTransparent ]).
	e defaultSkin: ToBackgroundColorSkinForTest new.
	space root addChild: e.
	self deny: e background isTransparent.
	self assert: goneHere
]
