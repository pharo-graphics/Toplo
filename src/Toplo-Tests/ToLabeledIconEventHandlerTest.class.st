"
A ToLabeledIconEventHandlerTest is a test class for testing the behavior of ToLabeledIconEventHandler
"
Class {
	#name : #ToLabeledIconEventHandlerTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core'
}

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testDirection [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.

	li beStartToEnd .
	li skinManager setSkinInstaller: nil in: li.
	li direction: BlLayoutDirection rightToLeft.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li direction: BlLayoutDirection rightToLeft.
	self assert: li skinManager skinInstaller isNil.

	li skinManager setSkinInstaller: nil in: li.
	li direction: BlLayoutDirection leftToRight.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li direction: BlLayoutDirection leftToRight.
	self assert: li skinManager skinInstaller isNil.

	li direction: BlLayoutDirection rightToLeft.
	self assert: li skinManager skinInstaller notNil
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testLayoutDirectionChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beStartToEnd.
	li beEndToStart.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li beStartToEnd.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li startToEnd: false.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li startToEnd: true.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li endToStart: true.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li endToStart: false.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testLayoutOrientationChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beHorizontal.
	li beVertical.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li beHorizontal.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li vertical: true.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li vertical: false.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li horizontal: false.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li horizontal: true.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testOrientation [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beStartToEnd.
	li skinManager setSkinInstaller: nil in: li.
	li orientation: BlLinearLayoutOrientation vertical.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li orientation: BlLinearLayoutOrientation vertical.
	self assert: li skinManager skinInstaller isNil.

	li skinManager setSkinInstaller: nil in: li.
	li orientation: BlLinearLayoutOrientation horizontal.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	li orientation: BlLinearLayoutOrientation horizontal.
	self assert: li skinManager skinInstaller isNil
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testlayoutConstraintsChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li exact: 10 @ 10.
	self assert: li skinManager skinInstaller notNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li fitContent.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li fitContentLimited.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li hExact: 20.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li hFitContent.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li hFitContentLimited.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li hMatchParent.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li matchParent.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li vExact: 20.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li vFitContent.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li vFitContentLimited.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil.
	li vMatchParent.
	self assert: li skinManager skinInstaller isNil.
	li skinManager setSkinInstaller: nil in: li.
	self assert: li skinManager skinInstaller isNil
]
