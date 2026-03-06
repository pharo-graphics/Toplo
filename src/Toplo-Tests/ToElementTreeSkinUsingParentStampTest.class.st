Class {
	#name : #ToElementTreeSkinUsingParentStampTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'parent',
		'child',
		'subChild'
	],
	#category : #'Toplo-Tests-Core-Skin'
}

{ #category : #running }
ToElementTreeSkinUsingParentStampTest >> newElementTree [

	parent := ToElement new.
	parent extent: 200 @ 200.
	parent background: Color blue.
	parent addStamp: #'parent-color' withValue: Color red.
	parent addStamp: #'child-color' withValue: Color blue.
	parent addStamp: #'subChild-color' withValue: Color yellow.
	parent defaultSkin: (ToScriptableSkin new onInstallSkinEvent: [:e :evt |
			  e background: (e valueOfStamp: #'parent-color') ]).

	child := ToElement new.
	child extent: 150 @ 150.
	child background: Color red.
	child defaultSkin: (ToScriptableSkin new onInstallSkinEvent: [:e :evt |
			  e background: (e parent valueOfStamp: #'child-color') ]).

	subChild := ToElement new.
	subChild extent: 100 @ 100.
	subChild background: Color green.
	subChild defaultSkin: (ToScriptableSkin new onInstallSkinEvent: [:e :evt |
			  e background: (e parent parent valueOfStamp: #'subChild-color') ]).

	child addChild: subChild.
	parent addChild: child.
	space root addChild: parent
]

{ #category : #running }
ToElementTreeSkinUsingParentStampTest >> setUp [ 

	super setUp.
	self newElementTree
]

{ #category : #tests }
ToElementTreeSkinUsingParentStampTest >> testChildSkinApplication [
	" updating a stamp in the parent should lead to the re-installation of children skins "

	parent updateStamp: #'child-color' withValue: Color white.
	self waitTestingSpaces.
	self assert: child background paint color equals: Color white
]

{ #category : #tests }
ToElementTreeSkinUsingParentStampTest >> testInitialSkinsApplication [

	self waitTestingSpaces.
	self assert: (parent background isKindOf: BlPaintBackground).
	self assert: (child background isKindOf: BlPaintBackground).
	self assert: (subChild background isKindOf: BlPaintBackground).
	self assert: parent background paint color equals: Color red.
	self assert: child background paint color equals: Color blue.
	self assert: subChild background paint color equals: Color yellow.

]

{ #category : #tests }
ToElementTreeSkinUsingParentStampTest >> testParentSkinApplication [
	" updating a stamp in the parent should lead to the re-installation of the parent skin "

	parent updateStamp: #'parent-color' withValue: Color brown.
	self waitTestingSpaces.
	self assert: parent background paint color equals: Color brown.	

]

{ #category : #tests }
ToElementTreeSkinUsingParentStampTest >> testSubChildSkinApplication [
	" updating a stamp in the parent should lead to the re-installation of children skins "

	parent updateStamp: #'subChild-color' withValue: Color black.
	self waitTestingSpaces.
	self assert: subChild background paint color equals: Color black
]
