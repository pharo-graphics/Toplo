"
A ToBoxLookTest is a test class for testing the behavior of ToBoxLook
"
Class {
	#name : #ToBoxLookTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Look'
}

{ #category : #tests }
ToBoxLookTest >> testBox [

	| w skin look |
	w := ToElement new.
	skin := ToWidgetSkin new.
	look := ToBoxLook new
		        width: [ :e | 10 ];
		        height: [ :e | 20 ];
		        margin: [ :e | BlInsets all: 3 ];
		        padding: [ :e | BlInsets all: 4 ];
		        yourself.
	skin addLook: look.
	w withSkin: skin.
	self assert: w privateSkin look equals: look.
	w switchToSkinState: ToInstallState new.
	self assert: w margin equals: (BlInsets all: 3).
	self assert: w padding equals: (BlInsets all: 4).
	" have to wait for the next layouting "
	self assert: w width equals: 0.
	self assert: w height equals: 0.
	w forceLayout.
	self assert: w width equals: 10.
	self assert: w height equals: 20.

]

{ #category : #tests }
ToBoxLookTest >> testNoBox [

	| w skin |
	w := ToElement new.
	skin := ToWidgetSkin new.
	skin addLook: ToBoxLook new.
	w withSkin: skin.
	w switchToSkinState: ToInitialState new.
	self assert: w width equals: 0.
	self assert: w height equals: 0.
	self assert: w margin equals: BlInsets empty.
	self assert: w padding equals: BlInsets empty
]
