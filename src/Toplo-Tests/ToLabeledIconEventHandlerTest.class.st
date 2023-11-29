"
A ToLabeledIconEventHandlerTest is a test class for testing the behavior of ToLabeledIconEventHandler
"
Class {
	#name : #ToLabeledIconEventHandlerTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core'
}

{ #category : #running }
ToLabeledIconEventHandlerTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 

]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testDirection [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.

	li beLeftToRight.
	li skinInstaller: nil.
	li direction: BlLayoutDirection rightToLeft.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li direction: BlLayoutDirection rightToLeft.
	self assert: li skinInstaller isNil.
	
	li skinInstaller: nil.
	li direction: BlLayoutDirection leftToRight.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li direction: BlLayoutDirection leftToRight.
	self assert: li skinInstaller isNil.

	li direction: BlLayoutDirection rightToLeft.
	self assert: li skinInstaller notNil.


]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testLayoutDirectionChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beLeftToRight.
	li beRightToLeft.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li beLeftToRight.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li leftToRight: false.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li leftToRight: true.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li rightToLeft: true.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li rightToLeft: false.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil

]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testLayoutOrientationChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beHorizontal.
	li beVertical.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li beHorizontal.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li vertical: true.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li vertical: false.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li horizontal: false.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li horizontal: true.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil

]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testOrientation [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beLeftToRight.
	li skinInstaller: nil.
	li orientation: BlLinearLayoutVerticalOrientation new.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li orientation: BlLinearLayoutVerticalOrientation new.
	self assert: li skinInstaller isNil.
	
	li skinInstaller: nil.
	li orientation: BlLinearLayoutHorizontalOrientation new.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	li orientation: BlLinearLayoutHorizontalOrientation new.
	self assert: li skinInstaller isNil.


]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testlayoutConstraintsChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li exact: 10@10.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li fitContent.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li fitContentLimited.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li hExact:20.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li hFitContent.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li hFitContentLimited.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li hMatchParent.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li matchParent.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li vExact: 20.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li vFitContent.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li vFitContentLimited.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.
	li vMatchParent.
	self assert: li skinInstaller notNil.
	li skinInstaller: nil.
	self assert: li skinInstaller isNil.


	
]
