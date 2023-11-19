"
A ToBeeThemeTest is a test class for testing the behavior of ToBeeTheme
"
Class {
	#name : #ToBeeThemeTest,
	#superclass : #TestCase,
	#category : 'Toplo-Theme-Bee-Tests'
}

{ #category : #test }
ToBeeThemeTest >> testColorPrimary [

	| theme |
	theme := ToBeeLightTheme new.
	self assert: theme colorPrimary notNil.
	self assert: theme colorPrimary equals: (ToBeeLightTheme new defaultColorPrimary).
	self assert: (theme stampNamed: #'color-primary') value equals: theme colorPrimary.
	theme colorPrimary: Color red.
	self assert: theme colorPrimary equals: Color red.
	self assert: (theme stampNamed: #'color-primary') value equals: theme colorPrimary.
	
	theme := ToBeeLightTheme colorPrimary: Color red.
	self assert: theme colorPrimary equals: Color red.
	self assert: (theme stampNamed: #'color-primary') value equals: theme colorPrimary.
	
	theme := ToBeeDarkTheme new.
	self assert: theme colorPrimary notNil.
	self assert: theme colorPrimary equals: (ToBeeDarkTheme new defaultColorPrimary).
	self assert: (theme stampNamed: #'color-primary') value equals: theme colorPrimary.
	theme colorPrimary: Color red.
	self assert: theme colorPrimary equals: Color red.
	self assert: (theme stampNamed: #'color-primary') value equals: theme colorPrimary.
	theme := ToBeeDarkTheme colorPrimary: Color red.
	self assert: theme colorPrimary equals: Color red.
	self assert: (theme stampNamed: #'color-primary') value equals: theme colorPrimary.

]

{ #category : #tests }
ToBeeThemeTest >> testSpaceRoot [

	| ssi space e |
	ssi := ToBeeLightTheme new.
	space := BlSpace new.
	space toTheme: ssi.
	e := (ToElement new
			 size: 100 @ 100;
			 position: 10 @ 10;
			 withStamp: #machin;
			 background: Color white).
	space root addChild: e.
	space applyAllSkinInstallers.
	space applyAllStyles.
	self assert: space root background paint color equals: (ssi styleSheet stampNamed: 'background-color') value.
	ssi := ToBeeDarkTheme new.
	space toTheme: ssi.
	space applyAllSkinInstallers.
	space applyAllStyles.
	self assert: space root background paint color equals: (ssi styleSheet stampNamed: 'background-color') value.



]
