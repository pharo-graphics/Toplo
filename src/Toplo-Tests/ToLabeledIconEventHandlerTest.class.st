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

	| li newSkinRequested |
	li := ToLabeledIcon new.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li beStartToEnd.
		li skinManager forceNewSkinRequested: false in: li.
		li direction: BlLayoutDirection rightToLeft.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li direction: BlLayoutDirection rightToLeft.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li direction: BlLayoutDirection leftToRight.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li direction: BlLayoutDirection leftToRight.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li direction: BlLayoutDirection rightToLeft.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testLayoutDirectionChangedEvent [

	| li newSkinRequested |
	li := ToLabeledIcon new.
	space deferAndSettle: [ space root addChild: li ].
	
	space deferAndSettle: [
		li beStartToEnd.
		li beEndToStart.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li beStartToEnd.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li startToEnd: false.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li startToEnd: true.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li endToStart: true.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li endToStart: false.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li ]
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testLayoutOrientationChangedEvent [

	| li newSkinRequested |
	li := ToLabeledIcon new.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li beHorizontal.
		li beVertical.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li beHorizontal.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li vertical: true.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li vertical: false.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li horizontal: false.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li horizontal: true.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li ]
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testOrientation [

	| li newSkinRequested |
	li := ToLabeledIcon new.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li beStartToEnd.
		li skinManager forceNewSkinRequested: false in: li.
		li orientation: BlLinearLayoutOrientation vertical.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li orientation: BlLinearLayoutOrientation vertical.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li orientation: BlLinearLayoutOrientation horizontal.
		newSkinRequested := li skinManager newSkinRequested ].
	self assert: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		li orientation: BlLinearLayoutOrientation horizontal.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested
]

{ #category : #'layout constraints' }
ToLabeledIconEventHandlerTest >> testlayoutConstraintsChangedEvent [

	| li newSkinRequested |
	li := ToLabeledIcon new.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li exact: 10 @ 10.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li fitContent.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li fitContentLimited.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li hExact: 20.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li hFitContent.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li hFitContentLimited.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li hMatchParent.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li matchParent.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li vExact: 20.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li vFitContent.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li vFitContentLimited.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li vMatchParent.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested.

	space deferAndSettle: [
		li skinManager forceNewSkinRequested: false in: li.
		newSkinRequested := li skinManager newSkinRequested ].
	self deny: newSkinRequested
]
