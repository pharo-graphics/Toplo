Class {
	#name : #ToBlElementTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
ToBlElementTest >> setUp [ 

	super setUp.
	element := BlElement new
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testAddAllStamps [

	element addAllStamps: {  }.
	self assert: element allStamps isEmpty.
	element addAllStamps: { #color. #background }.
	self assert: element allStamps size equals: 2.
	self assert: (element hasStamp: #color).	
	self assert: (element hasStamp: #background).
	element addAllStamps: { #blob }.
	self assert: element allStamps size equals: 3.
	self assert: (element hasStamp: #color).	
	self assert: (element hasStamp: #background).
	self assert: (element hasStamp: #blob).


]

{ #category : #'tests - token properties' }
ToBlElementTest >> testAddAllTokenProperties [

	| s |
	element addAllTokenProperties: {
			(#color1 -> Color blue) asTokenProperty.
			(#color2 -> Color red) asTokenProperty }.
	self assert:
		(s := element tokenPropertyMap propertyNamed: #color1) notNil.
	self assert:
		(s := element tokenPropertyMap propertyNamed: #color2) notNil.
	self assert: element tokenPropertyMap size equals: 2.
	element tokenPropertyMap addAllProperties: {
			(#color1 -> Color white) asTokenProperty.
			(#color2 -> Color yellow) asTokenProperty }.
	self assert: element  tokenPropertyMap size equals: 2.
	self assert: (element tokenPropertyMap propertyNamed: #color1) value equals: Color white.
	self assert: (element tokenPropertyMap propertyNamed: #color2) value equals: Color yellow.

]

{ #category : #'tests - stamp' }
ToBlElementTest >> testAddStamp [

	element addAllStamps: {  }.
	element addStamp: #color.
	element addStamp: #background.
	self assert: element allStamps size equals: 2.
	self assert: (element hasStamp: #color).	
	self assert: (element hasStamp: #background).
	element addStamp: #color.
	self assert: element allStamps size equals: 2.
	element addStamp: #blob.
	self assert: (element hasStamp: #color).	
	self assert: (element hasStamp: #background).
	self assert: (element hasStamp: #blob)

]

{ #category : #'tests - token properties' }
ToBlElementTest >> testAddTokenProperty [

	| s s2 |
	element ensuredTokenPropertyMap addProperty: (#color -> Color blue) asTokenProperty.
	self assert: (s := element tokenPropertyMap propertyNamed: #color) notNil.
	self assert: (s isKindOf: ToTokenProperty).
	self assert: s name equals: #color.
	self assert: s value equals: Color blue.
	self assert: element tokenPropertyMap size equals: 1.
	element tokenPropertyMap addProperty: (#color -> Color red) asTokenProperty.
	self assert: (s2 := element tokenPropertyMap propertyNamed: #color) notNil.
	self assert: s2 name equals: #color.
	self assert: s2 value equals: Color red.
	self assert: s ~~ s2.
	self assert: element tokenPropertyMap size equals: 1
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testAllStamps [

	element addAllStamps: {  }.
	self assert: element allStamps isEmpty.
	element addAllStamps: { #color. #background }.
	self assert: element allStamps size equals: 2.
	self assert: (element hasStamp: #color).	
	self assert: (element hasStamp: #background)
]

{ #category : #tests }
ToBlElementTest >> testApplicableListenersFor [

	| theme |
	theme := ToStyleSheetThemeForTest new.
	space toTheme: theme.
	space root addChild: element.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: (theme applicableListenersFor: element) size equals: 0
	
]

{ #category : #tests }
ToBlElementTest >> testBlElementShouldNotHaveSkinManager [

	element background: Color red.
	element border: Color black.
	self assert: element skinManager isNil.
	space root addChild: element.
	self assert: element skinManager isNil.
	self waitTestingSpaces.
	self assert: element skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: element skinManager isNil.

]

{ #category : #tests }
ToBlElementTest >> testBlElementShouldNotHaveSkinManagerEvenAsChildOfAToElement [

	|  pane |
	pane := ToPane vertical.
	element background: Color red.
	element border: Color black.
	pane addChild: element.
	self assert: element skinManager isNil.
	space root addChild: pane.
	self assert: element skinManager isNil.
	self waitTestingSpaces.
	self assert: element skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: element skinManager isNil.



]

{ #category : #tests }
ToBlElementTest >> testElementRemovedFromSceneGraph [
	" test that a requestUninstallSkin is sent to an element when it is removed from a space. "
	" this ensures that the skin is removed if the element is added back as a child."

	space root addChild: element.
	self assert: element skinManager isNil.
	space root removeChild: element.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: element skinManager isNil.

	
	
]

{ #category : #tests }
ToBlElementTest >> testEnsureCanManageToploSkin [

	element ensureCanManageToploSkin.
	space root addChild: element.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: element skinManager installedSkin isThemeSkin 
]

{ #category : #'tests - skin manager' }
ToBlElementTest >> testEnsureHaveSkinManager [ 

	| skinManager |
	element ensureHaveSkinManager.
	skinManager := element skinManager.
	self assert: (skinManager isKindOf: element toploExtension skinManagerClass)
]

{ #category : #'tests - skin manager' }
ToBlElementTest >> testEnsuredSkinManager [ 

	| skinManager |
	skinManager := element ensuredSkinManager.
	self assert: (skinManager isKindOf: element toploExtension skinManagerClass)
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testEnsuredStampMap [

	| map |
	self assert: element stampMap  isNil.
	map := element ensuredStampMap.
	self assert: map notNil.
	self assert: map identicalTo: element stampMap
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testEnsuredTokenPropertyMap [

	| map |
	self assert: element tokenPropertyMap isNil.
	map := element ensuredTokenPropertyMap.
	self assert: map notNil.
	self assert: map identicalTo: element tokenPropertyMap
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testHasAllStamps [

	element addAllStamps: {  }.
	self assert: element allStamps isEmpty.
	element addAllStamps: { #color. #background }.
	self assert: (element hasAllStamps: { #color. #background }).	
	self deny: (element hasAllStamps: { #something. #background }).	

]

{ #category : #'tests - stamp' }
ToBlElementTest >> testHasStamp [

	element addAllStamps: {  }.
	self assert: element allStamps isEmpty.
	element addAllStamps: { #color. #background }.
	self assert: (element hasStamp: #color ).	
	self deny: (element hasStamp: #something ).	

]

{ #category : #'tests - token properties' }
ToBlElementTest >> testHasTokenPropertyNamed [

	self deny: (element ensuredTokenPropertyMap hasPropertyNamed: #color).
	element tokenPropertyMap addProperty: (#color -> Color blue) asTokenProperty.
	self assert: (element tokenPropertyMap hasPropertyNamed: #color).
	element tokenPropertyMap addProperty: (#background -> Color blue) asTokenProperty.
	element tokenPropertyMap addProperty: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	element tokenPropertyMap addProperty: (#something -> #something) asTokenProperty.
	self assert: (element tokenPropertyMap hasPropertyNamed: #something).
	self assert: (element tokenPropertyMap hasPropertyNamed: #color)
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testLocalTokenPropertyNamed [

	| s |
	self assert: (element ensuredTokenPropertyMap propertyNamed: #color) isNil.
	(element ensuredTokenPropertyMap)
		addProperty: #color asTokenProperty.
	s := element tokenPropertyMap propertyNamed: #color.
	self assert: s notNil.
	self assert: (s isKindOf: ToTokenProperty).
	self assert: s name equals: #color.
	self assert: s value
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testRemoveAllStamps [

	element addStamp: (#color1).
	element addStamp: (#color2 ).
	self assert: element allStamps size equals: 2.
	element removeAllStamps.
	self assert: element allStamps isEmpty.
	element removeStamp: #color.
	self assert: element allStamps isEmpty
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testRemoveAllStamps2 [

	element addStamp: (#color1).
	element addStamp: (#color2 ).
	element addStamp: (#color3).
	element addStamp: (#color4 ).
	self assert: element allStamps size equals: 4.
	element removeAllStamps: { #color1. #color3 }.
	self assert: element allStamps asSet equals: #(#color2 #color4) asSet
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testRemoveStamp [

	element addAllStamps: {  }.
	element  addStamp: #color.
	element  addStamp: #background.
	self assert: element  allStamps size equals: 2.
	self assert: (element  hasStamp: #color).
	self assert: (element  hasStamp: #background).
	element  removeStamp: #color.
	self assert: element  allStamps size equals: 1.
	element  removeStamp: #blob.
	self deny: (element  hasStamp: #color).
	self assert: (element  hasStamp: #background)
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testRemoveTokenPropertyNamed [

	element ensuredTokenPropertyMap addProperty:
		(#color1 -> Color blue) asTokenProperty.
	element tokenPropertyMap addProperty:
		(#color2 -> Color blue) asTokenProperty.
	self assert: element tokenPropertyMap size equals: 2.
	element tokenPropertyMap removePropertyNamed: #color1.
	self assert: element tokenPropertyMap size equals: 1.
	element tokenPropertyMap removePropertyNamed: #color2.
	self assert: element tokenPropertyMap isEmpty
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testRemoveTokenPropertyNamed2 [

	element ensuredTokenPropertyMap addProperty: (#color -> Color blue) asTokenProperty.
	self assert: element tokenPropertyMap size equals: 1.
	element tokenPropertyMap removePropertyNamed: #color.
	self assert: element tokenPropertyMap isEmpty.
	element tokenPropertyMap removePropertyNamed: #color.
	self assert: element tokenPropertyMap isEmpty
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testRemoveTokenPropertyNamed4 [

	element ensuredTokenPropertyMap addProperty: (#color -> Color blue) asTokenProperty.
	self assert: element tokenPropertyMap size equals: 1.
	element tokenPropertyMap removePropertyNamed: #color.
	self assert: element tokenPropertyMap isEmpty.
	element tokenPropertyMap removePropertyNamed: #color.
	element tokenPropertyMap addProperty: (#color -> Color red) asTokenProperty.
	self assert: element tokenPropertyMap size equals: 1.
	element tokenPropertyMap removePropertyNamed: #blob .
	self assert: element tokenPropertyMap size equals: 1.
	element tokenPropertyMap removePropertyNamed: #color.
	self assert: element tokenPropertyMap isEmpty.


]

{ #category : #tests }
ToBlElementTest >> testRequestSkin [

	self assert: element skinManager isNil.
	self assert: element skinManager isNil.
	self assert: element skinManager isNil.
	element ensuredSkinManager requestNewSkinIn: element.
	self assert: element skinManager newSkinRequested.
	self assert: element skinManager installedSkin isUnknownSkin .
	space root addChild: element.
	self assert: element skinManager newSkinRequested.
	self assert: element skinManager installedSkin isUnknownSkin.
	space applyAllSkinInstallers.
	self deny: element skinManager newSkinRequested.
	self assert: element skinManager installedSkin isThemeSkin 
	
]

{ #category : #tests }
ToBlElementTest >> testRequestSkin2 [

	self assert: element skinManager isNil.
	self assert: element skinManager isNil.
	self assert: element skinManager isNil.
	space root addChild: element.
	self assert: element skinManager isNil.
	element ensuredSkinManager requestNewSkinIn: element.
	self assert: element skinManager notNil.
	self deny: element skinManager newSkinRequested.
	self assert: element skinManager installedSkin isThemeSkin.
	" apply skin installer from space has no effect on e since it has no skinInstaller "
	space applyAllSkinInstallers.
	self deny: element skinManager newSkinRequested.
	self assert: element skinManager installedSkin isThemeSkin
]

{ #category : #'tests - styleSheet' }
ToBlElementTest >> testSetStyleSheetIn [

	element ensuredToploExtension setStyleSheet: ToStyleSheet new in: element.
	self assert: element toploExtension styleSheet notNil.
	self assert: element styleSheet identicalTo: element toploExtension styleSheet
]

{ #category : #'tests - skin manager' }
ToBlElementTest >> testSkinManager [ 

	| skinManager |
	skinManager := element skinManager.
	self assert: skinManager isNil
	
]

{ #category : #'tests - skin manager' }
ToBlElementTest >> testSkinManagerDo [

	| skinManager |
	element skinManagerDo: [ :sm |
		skinManager := sm ].
	self assert: skinManager isNil.
	element ensureHaveSkinManager.
	element skinManagerDo: [ :sm |
		skinManager := sm ].
	self assert:
		(skinManager isKindOf: element toploExtension skinManagerClass)
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testStampMap [

	self assert: element stampMap  isNil
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testStampPropertyNamed [

	element addStamp: #color.
	element  addStamp: #background.
	self assert: ((element stampMap propertyNamed: #color) isKindOf: ToStampProperty).
	self should: [ element stampMap propertyNamed: #something ifAbsent: [ Error new signal ]] raise: Error
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testStampValue [

	element addStamp: #color withValue: Color blue.
	element addStamp: #background withValue: Color red.
	element addStamp: #primary.
	self assert: (element stampValue: #color) equals: Color blue.
	self assert: (element stampValue: #background) equals: Color red.
	self assert: (element stampValue: #primary).
	self should: [ element stampValue: #something ] raise: Error
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testTokenPropertyMap [

	| dict |
	dict := element tokenPropertyMap.
	self assert: dict isNil.

]

{ #category : #'tests - token properties' }
ToBlElementTest >> testTokenPropertyNamed [

	| p |
	self assert: (element tokenPropertyMap) isNil.
	element ensuredTokenPropertyMap addProperty: (p := (#color -> Color blue) asTokenProperty).
	self assert: (element tokenPropertyMap propertyNamed: #color) equals: p.
	element tokenPropertyMap addProperty: (#background -> Color blue) asTokenProperty.
	element tokenPropertyMap addProperty: (#layout -> BlLinearLayout horizontal) asTokenProperty.
	element tokenPropertyMap addProperty: (p := (#something -> #something) asTokenProperty).
	self assert: (element tokenPropertyMap propertyNamed: #something) equals: p.
	self assert: (element tokenPropertyMap propertyNamed: #color) notNil
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testTokenPropertyNamedFromBeforeSpaceShown [

	element := ToElement new.
	space root addChild: element.
	element valueOfTokenNamed: #'background-color'
]

{ #category : #'tests - token properties' }
ToBlElementTest >> testTokenPropertyNamedFromBeforeSpaceShown2 [

	| e goneHere |
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

{ #category : #'tests - token properties' }
ToBlElementTest >> testTokenPropertyNamedRequiresSpaceSkinPhasesStarted [

	| e goneHere |
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

{ #category : #tests }
ToBlElementTest >> testUnsortedApplicableListenersFor [

	| theme e |
	theme := ToStyleSheetThemeForTest new.
	space toTheme: theme.
	space root addChild: element.
	self assert: (theme unsortedApplicableListenersFor: element) size equals: 0.
	e := ToElement new.
	space root addChild: e.
	self assert: (theme unsortedApplicableListenersFor: e) size equals: 5.

	
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testValueOfTokenNamed [

	| theme |
	element ensureCanManageToploSkin.
	theme := ToRawThemeForTest new.
	space toTheme: theme.
	space root addTokenNamed: #testToken withValue: Color blue.
	space root addChild: element.
	self assert: (element valueOfTokenNamed: #testToken) equals: Color blue
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testValueOfTokenNamed2 [

	| theme |
	element ensureCanManageToploSkin.
	theme := ToRawThemeForTest new.
	space root addTokenNamed: #testToken withValue: Color blue.
	space toTheme: theme.
	space root addChild: element.
	self assert: (element valueOfTokenNamed: #testToken) equals: Color blue
]

{ #category : #'tests - stamp' }
ToBlElementTest >> testValueOfTokenNamedWithNotFoundToken [

	| theme notFoundDispatched |
	element ensureCanManageToploSkin.
	theme := ToRawThemeForTest new.
	space root addTokenNamed: #testToken withValue: Color blue.
	" normally, the token should not be found because the element is not added in the space root. 
	The fallback procedure is applied. see BlElement>>valueOfTokenNamed:"
	notFoundDispatched := false.
	element
		addEventHandlerOn: ToTokenPropertyNotFoundEvent
		do: [ notFoundDispatched := true ].
	self
		should: [ element valueOfTokenNamed: #testToken ]
		raise: ToTokenPropertyNotFoundError.
	self assert: notFoundDispatched.
	element addTokenNamed: #testToken withValue: Color blue.
	self assert: (element valueOfTokenNamed: #testToken) equals: Color blue.
	element addTokenNamed: #testToken withValue: Color yellow.
	space root addChild: element.
	self assert: (element valueOfTokenNamed: #testToken) equals: Color yellow.
	element removeFromParent.
	self assert: (element valueOfTokenNamed: #testToken) equals: Color yellow
]
