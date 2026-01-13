"
A ToElementExtensionTest is a test class for testing the behavior of ToElementExtension
"
Class {
	#name : #ToElementExtensionTest,
	#superclass : #TestCase,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
ToElementExtensionTest >> setUp [ 

	super setUp.
	element := BlElement new
]

{ #category : #'tests - skin manager' }
ToElementExtensionTest >> testEnsureHaveSkinManager [ 

	| skinManager |
	element ensuredToploExtension ensureHaveSkinManager.
	skinManager := element toploExtension skinManager.
	self assert: (skinManager isKindOf: element toploExtension skinManagerClass)
]

{ #category : #tests }
ToElementExtensionTest >> testEnsureHaveToploExtension [

	element ensureHaveToploExtension.
	self assert: (element toploExtension isKindOf: element toploExtensionClass)
]

{ #category : #'tests - skin manager' }
ToElementExtensionTest >> testEnsuredSkinManager [ 

	| skinManager |
	skinManager := element ensuredToploExtension ensuredSkinManager.
	self assert: (skinManager isKindOf: element toploExtension skinManagerClass)
	
]

{ #category : #tests }
ToElementExtensionTest >> testEnsuredToploExtension [

	| extension |
	extension := element ensuredToploExtension.
	self assert: (extension isKindOf: element toploExtensionClass).
	self assert: extension identicalTo: element ensuredToploExtension
]

{ #category : #tests }
ToElementExtensionTest >> testNewElement [

	self assert: element toploExtension isNil
]

{ #category : #'tests - styleSheet' }
ToElementExtensionTest >> testSetStyleSheetIn [

	element ensuredToploExtension setStyleSheet: ToStyleSheet new in: element.
	self assert: element toploExtension styleSheet notNil
]

{ #category : #'tests - skin manager' }
ToElementExtensionTest >> testSkinManager [ 

	| skinManager |
	skinManager := element ensuredToploExtension skinManager.
	self assert: skinManager isNil
	
]

{ #category : #'tests - skin manager' }
ToElementExtensionTest >> testSkinManagerDo [

	| skinManager |
	element ensuredToploExtension skinManagerDo: [ :sm |
		skinManager := sm ].
	self assert: skinManager isNil.
	element toploExtension ensureHaveSkinManager.
	element ensuredToploExtension skinManagerDo: [ :sm |
		skinManager := sm ].
	self assert:
		(skinManager isKindOf: element toploExtension skinManagerClass)
]
