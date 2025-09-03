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
	li skinManager forceNewSkinRequested: false in: li.
	li direction: BlLayoutDirection rightToLeft.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li direction: BlLayoutDirection rightToLeft.
	self deny: li skinManager newSkinRequested.

	li skinManager forceNewSkinRequested: false in: li.
	li direction: BlLayoutDirection leftToRight.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li direction: BlLayoutDirection leftToRight.
	self deny: li skinManager newSkinRequested.

	li direction: BlLayoutDirection rightToLeft.
	self assert: li skinManager newSkinRequested
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testLayoutDirectionChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beStartToEnd.
	li beEndToStart.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li beStartToEnd.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li startToEnd: false.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li startToEnd: true.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li endToStart: true.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li endToStart: false.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.

]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testLayoutOrientationChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beHorizontal.
	li beVertical.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li beHorizontal.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li vertical: true.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li vertical: false.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li horizontal: false.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li horizontal: true.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.

]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testOrientation [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li beStartToEnd.
	li skinManager forceNewSkinRequested: false in: li.
	li orientation: BlLinearLayoutOrientation vertical.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li orientation: BlLinearLayoutOrientation vertical.
	self deny: li skinManager newSkinRequested.

	li skinManager forceNewSkinRequested: false in: li.
	li orientation: BlLinearLayoutOrientation horizontal.
	self assert: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	li orientation: BlLinearLayoutOrientation horizontal.
	self deny: li skinManager newSkinRequested
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testlayoutConstraintsChangedEvent [

	| li |
	li := ToLabeledIcon new.
	space root addChild: li.
	li exact: 10 @ 10.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li fitContent.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li fitContentLimited.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li hExact: 20.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li hFitContent.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li hFitContentLimited.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li hMatchParent.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li matchParent.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li vExact: 20.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li vFitContent.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li vFitContentLimited.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.
	li vMatchParent.
	self deny: li skinManager newSkinRequested.
	li skinManager forceNewSkinRequested: false in: li.
	self deny: li skinManager newSkinRequested.

]
