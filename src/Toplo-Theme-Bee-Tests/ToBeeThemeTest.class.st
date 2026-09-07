Class {
	#name : #ToBeeThemeTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Theme-Bee-Tests'
}

{ #category : #running }
ToBeeThemeTest >> setUp [ 

	super setUp.
	space toTheme: ToBeeTheme new
]

{ #category : #tests }
ToBeeThemeTest >> testDefaultButtonSkin [

	| button |
	button := ToButton new.
	space deferAndSettle: [ space root addChild: button ].

	self assert: button border width equals: (button valueOfTokenNamed: #'line-width').
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: (button valueOfTokenNamed: #'color-border').
]

{ #category : #tests }
ToBeeThemeTest >> testSpaceRoot [

	| theme e |
	theme := ToStyleSheetTheme new.
	e := ToElement new
		     extent: 100 @ 100;
		     position: 10 @ 10;
		     addStamp: #machin;
		     background: Color white.
	space deferAndSettle: [
		space toTheme: theme.
		space root addChild: e ].
	self
		assert: space root background paint color
		equals: (space root valueOfTokenNamed: 'background-color').
	theme := ToBeeDarkTheme new.
	space deferAndSettle: [ space toTheme: theme ].
	self
		assert: space root background paint color
		equals: (space root valueOfTokenNamed: 'background-color')
]

{ #category : #tests }
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
