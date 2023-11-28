"
A ToBeeThemeTest is a test class for testing the behavior of ToBeeTheme
"
Class {
	#name : 'ToBeeThemeTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Theme-Bee-Tests',
	#package : 'Toplo-Theme-Bee-Tests'
}

{ #category : 'tests' }
ToBeeThemeTest >> testSpaceRoot [

	| theme space e |
	theme := ToBeeLightTheme new.
	space := BlSpace new.
	space toTheme: theme.
	e := (ToElement new
			 size: 100 @ 100;
			 position: 10 @ 10;
			 addStamp: #machin;
			 background: Color white).
	space root addChild: e.
	space applyAllSkinInstallers.
	space applyAllStyles.
	self assert: space root background paint color equals: (space root tokenValueNamed: 'background-color').
	theme := ToBeeDarkTheme new.
	space toTheme: theme.
	space applyAllSkinInstallers.
	space applyAllStyles.
	self assert: space root background paint color equals: (space root tokenValueNamed: 'background-color').



]
