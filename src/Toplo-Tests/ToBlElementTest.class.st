Class {
	#name : #ToBlElementTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core'
}

{ #category : #tests }
ToBlElementTest >> testBlElementShouldNotHaveSkinManager [

	| dem |
	dem := BlElement new.
	dem background: Color red.
	dem border: Color black.
	self assert: dem skinManager isNil.
	space root addChild: dem.
	self assert: dem skinManager isNil.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.

]

{ #category : #tests }
ToBlElementTest >> testBlElementShouldNotHaveSkinManagerEvenAsChildOfAToElement [

	| dem pane |
	pane := ToPane vertical.
	dem := BlElement new.
	dem background: Color red.
	dem border: Color black.
	pane addChild: dem.
	self assert: dem skinManager isNil.
	space root addChild: pane.
	self assert: dem skinManager isNil.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.
	self applyAllEnqueuedStates.
	self waitTestingSpaces.
	self assert: dem skinManager isNil.



]
