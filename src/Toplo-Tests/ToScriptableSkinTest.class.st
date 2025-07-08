"
A ToScriptableSkinTest is a test class for testing the behavior of ToScriptableSkin
"
Class {
	#name : #ToScriptableSkinTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core-Skin'
}

{ #category : #tests }
ToScriptableSkinTest >> testOnHoveredSkinEvent [

	| te skin |
	te := ToElement new.
	te extent: 100 asPoint.
	skin := ToScriptableSkin new.
	skin onHoveredSkinEvent: [ :e :evt |
		e extent: 30 asPoint.
		e background: Color yellow ].
	te defaultRawSkin: skin.
	space root addChild: te.
	space startToploPhases.
	BlSpace simulateMouseMoveInside: te.
	self waitTestingSpaces.
	self assert: te background paint color equals: Color yellow.
	self assert: te size equals: 30 asPoint
]

{ #category : #tests }
ToScriptableSkinTest >> testOnInstalledSkinEvent [

	| te skin |
	te := ToElement new.
	skin := ToScriptableSkin new.
	skin onInstallSkinEvent: [ :e :evt |
		e extent: 30 asPoint.
		e background: Color yellow ].
	te defaultRawSkin: skin.
	space root addChild: te.
	space startToploPhases.
	self waitTestingSpaces.
	self assert: te background paint color equals: Color yellow.
	self assert: te size equals: 30 asPoint
]

{ #category : #tests }
ToScriptableSkinTest >> testOnLeftSkinEvent [

	| te skin |
	te := ToElement new.
	te extent: 100 asPoint.
	skin := ToScriptableSkin new.
	skin onLeftSkinEvent: [ :e :evt |
		e extent: 30 asPoint.
		e background: Color yellow ].
	te defaultRawSkin: skin.
	space root addChild: te.
	space startToploPhases.
	BlSpace simulateMouseMoveInside: te.
	BlSpace simulateMouseMoveOutside: te.
	self waitTestingSpaces.
	self assert: te background paint color equals: Color yellow.
	self assert: te size equals: 30 asPoint
]
