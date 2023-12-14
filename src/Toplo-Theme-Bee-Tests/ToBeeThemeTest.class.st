"
A ToBeeThemeTest is a test class for testing the behavior of ToBeeTheme
"
Class {
	#name : 'ToBeeThemeTest',
	#superclass : 'ToParameterizedHostTest',
	#category : 'Toplo-Theme-Bee-Tests',
	#package : 'Toplo-Theme-Bee-Tests'
}

{ #category : 'running' }
ToBeeThemeTest >> setUp [ 

	super setUp.
	space toTheme: ToBeeTheme light.
]

{ #category : 'tests' }
ToBeeThemeTest >> testDefaultButtonSkin [

	| button |
	button := ToButton new.
	space root addChild: button.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.

	self assert: button border width equals: (button tokenValueNamed: #'line-width').
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: (button tokenValueNamed: #'color-border').
]

{ #category : 'tests' }
ToBeeThemeTest >> testSpaceRoot [

	| theme e |
	theme := ToStyleSheetTheme light.
	space := self newTestingSpace.
	space toTheme: theme.
	e := (ToElement new
			 size: 100 @ 100;
			 position: 10 @ 10;
			 addStamp: #machin;
			 background: Color white).
	space root addChild: e.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: space root background paint color equals: (space root tokenValueNamed: 'background-color').
	theme := ToBeeTheme dark.
	space toTheme: theme.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: space root background paint color equals: (space root tokenValueNamed: 'background-color').



]

{ #category : 'tests' }
ToBeeThemeTest >> testWriteablePropertyList [

	| index count  |

	index := IdentityDictionary new.
	space toTheme styleSheet defaultWritablePropertyList do: [ :p |
		index at: p name ifAbsentPut: [ 0 ].
		count := (index at: p name) + 1.
		index at: p name put: count ].
	index keysAndValuesDo: [ :k :v | self assert: v identicalTo: 1 ].
	space toTheme styleSheet defaultWritablePropertyList do: [ :p | self assert: (space toTheme styleSheet writablePropertyNamed: p name) notNil ]
]
