Class {
	#name : #ToElementTreeSkinUsingTokenPropertiesTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'parent',
		'child',
		'subChild'
	],
	#category : #'Toplo-Tests-Core-Skin'
}

{ #category : #running }
ToElementTreeSkinUsingTokenPropertiesTest >> newElementTree [

	parent := ToElement new.
	parent extent: 200 @ 200.
	parent background: Color blue.
	parent addTokenNamed: #'element-color' withValue: Color black.
	parent defaultSkin: (ToScriptableSkin new onInstallSkinEvent: [:e :evt |
			  e background: (e valueOfTokenNamed: #'element-color') ]).

	child := ToElement new.
	child extent: 150 @ 150.
	child background: Color red.
	child defaultSkin: (ToScriptableSkin new onInstallSkinEvent: [:e :evt |
			  e background: (e valueOfTokenNamed: #'element-color') ]).

	subChild := ToElement new.
	subChild extent: 100 @ 100.
	subChild background: Color green.
	subChild defaultSkin: (ToScriptableSkin new onInstallSkinEvent: [:e :evt |
			  e background: (e valueOfTokenNamed: #'element-color') ]).

	child addChild: subChild.
	parent addChild: child.
	space root addChild: parent
]

{ #category : #running }
ToElementTreeSkinUsingTokenPropertiesTest >> setUp [ 

	super setUp.
	self newElementTree
]

{ #category : #tests }
ToElementTreeSkinUsingTokenPropertiesTest >> testChildSkinApplication [
	" updating a token value in the parent should lead to the re-installation of children skins "

	parent updateTokenNamed: #'element-color' withValue: Color white.
	self waitTestingSpaces.
	self assert: child background paint color equals: Color white
]

{ #category : #tests }
ToElementTreeSkinUsingTokenPropertiesTest >> testInitialSkinsApplication [

	self waitTestingSpaces.
	self assert: (parent background isKindOf: BlPaintBackground).
	self assert: (child background isKindOf: BlPaintBackground).
	self assert: (subChild background isKindOf: BlPaintBackground).
	self assert: parent background paint color equals: Color black.
	self assert: child background paint color equals: Color black.
	self assert: subChild background paint color equals: Color black.

]

{ #category : #tests }
ToElementTreeSkinUsingTokenPropertiesTest >> testParentSkinApplication [
	" updating a token value in the parent should lead to the re-installation of the parent skin "

	parent updateTokenNamed: #'element-color' withValue: Color white.
	self waitTestingSpaces.
	self assert: parent background paint color equals: Color white.	

]

{ #category : #tests }
ToElementTreeSkinUsingTokenPropertiesTest >> testRemovingTokenLeadsToError [
	" updating a token value in the parent should lead to the re-installation of children skins "

	parent removeTokenNamed: #'element-color'.
	self should: [ self waitTestingSpaces ] raise: ToTokenPropertyNotFoundError.
	" add the token back because #tearDown sends #waitTestingSpaces "
	parent addTokenNamed: #'element-color' withValue: Color black.
]

{ #category : #tests }
ToElementTreeSkinUsingTokenPropertiesTest >> testSubChildSkinApplication [
	" updating a token value in the parent should lead to the re-installation of children skins "

	parent updateTokenNamed: #'element-color' withValue: Color white.
	self waitTestingSpaces.
	self assert: subChild background paint color equals: Color white
]

{ #category : #tests }
ToElementTreeSkinUsingTokenPropertiesTest >> testSubChildWithLocalTokenSkinApplication [
	" updating a token value in the parent should lead to the re-installation of children skins "

	parent updateTokenNamed: #'element-color' withValue: Color white.
	child addTokenNamed: #'element-color' withValue: Color gray.
	self waitTestingSpaces.
	self assert: parent background paint color equals: Color white.
	self assert: child background paint color equals: Color gray.
	self assert: subChild background paint color equals: Color gray.
	child removeTokenNamed: #'element-color'.
	self waitTestingSpaces.
	self assert: subChild background paint color equals: Color white
]
