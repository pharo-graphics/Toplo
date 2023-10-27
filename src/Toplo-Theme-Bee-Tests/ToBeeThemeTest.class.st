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

	| ssi space e |
	ssi := ToBeeDarkTheme new.
	space := BlSpace new.
	space toTheme: ssi.
	e := (ToElement new
			 size: 100 @ 100;
			 position: 10 @ 10;
			 withStamp: #machin;
			 background: Color white).
	space root addChild: e.
	space show
]
