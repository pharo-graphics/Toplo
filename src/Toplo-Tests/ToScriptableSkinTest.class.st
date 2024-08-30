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
	skin := ToScriptableSkin new.
	skin onHoveredSkinEvent: [ :e |
		e size: 30 asPoint.
		e background: Color yellow ].
	te defaultRawSkin: skin.
	space root addChild: te.
	space startSkinPhases.
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
	skin onInstallSkinEvent: [ :e |
		e size: 30 asPoint.
		e background: Color yellow ].
	te defaultRawSkin: skin.
	space root addChild: te.
	space startSkinPhases.
	self waitTestingSpaces.
	self assert: te background paint color equals: Color yellow.
	self assert: te size equals: 30 asPoint
]

{ #category : #tests }
ToScriptableSkinTest >> testOnLeavedSkinEvent [

	| te skin |
	te := ToElement new.
	skin := ToScriptableSkin new.
	skin onLeavedSkinEvent: [ :e |
		e size: 30 asPoint.
		e background: Color yellow ].
	te defaultRawSkin: skin.
	space root addChild: te.
	space startSkinPhases.
	BlSpace simulateMouseMoveInside: te.
	BlSpace simulateMouseMoveOutside: te.
	self waitTestingSpaces.
	self assert: te background paint color equals: Color yellow.
	self assert: te size equals: 30 asPoint
]
