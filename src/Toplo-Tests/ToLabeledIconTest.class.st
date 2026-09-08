"
A ToLabeledIconTest is a test class for testing the behavior of ToLabeledIcon
"
Class {
	#name : #ToLabeledIconTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Tests-Core'
}

{ #category : #helpers }
ToLabeledIconTest >> newLabeledIcon [

	^ ToLabeledIcon new
]

{ #category : #helpers }
ToLabeledIconTest >> newLabeledIconWithIcon [

	| li |
	li := self newLabeledIcon.
	li icon:
		(ToImage inner:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself)).
	^ li
]

{ #category : #running }
ToLabeledIconTest >> setUp [ 

	super setUp.
	ToTheme cleanUp
]

{ #category : #tests }
ToLabeledIconTest >> testBeIconFirst [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li iconImage:
			(BlElement new
				 extent: 60 @ 20;
				 background: (Color blue alpha: 0.2);
				 yourself).
		li beStartToEnd ].

	self assert: li isStartToEnd
]

{ #category : #tests }
ToLabeledIconTest >> testBeLabelFirst [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li iconImage:
			(BlElement new
				 extent: 60 @ 20;
				 background: (Color blue alpha: 0.2);
				 yourself).
		li beEndToStart ].

	self assert: li isEndToStart
]

{ #category : #tests }
ToLabeledIconTest >> testFiller [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	self assert: li startFiller isNil.

	space deferAndSettle: [ li startFlexible: false ].
	self assert: li startFiller isNil.

	space deferAndSettle: [ li startFlexible: true ].
	self assert: li startFiller notNil
]

{ #category : #tests }
ToLabeledIconTest >> testHasIcon [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	self deny: li hasIcon.

	space deferAndSettle: [
		li icon:
			(ToImage inner:
				(BlElement new
					extent: 60 @ 20;
					background: (Color blue alpha: 0.2);
					yourself)) ].

	self assert: li hasIcon
]

{ #category : #tests }
ToLabeledIconTest >> testHasLabel [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	self deny: li hasLabel.

	space deferAndSettle: [ li label: (ToLabel text: 'A') ].

	self assert: li hasLabel
]

{ #category : #tests }
ToLabeledIconTest >> testIcon [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li icon:
			(ToImage inner:
				(BlElement new
					extent: 60 @ 20;
					background: (Color blue alpha: 0.2);
					yourself)) ].
	self assert: li width equals: li iconContainer width.
	self assert: li height equals: li iconContainer height.
	self assert: li hasIcon.

	space deferAndSettle: [ li icon: nil ].
	self assert: li icon isNil.
	self deny: li hasIcon
]

{ #category : #tests }
ToLabeledIconTest >> testIconContainer [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	self assert: li iconContainer isNil.

	space deferAndSettle: [
		li icon:
			(ToImage inner:
				(BlElement new
					extent: 60 @ 20;
					background: (Color blue alpha: 0.2);
					yourself)) ].
	self assert: li startContainer notNil.
	self assert: li width equals: li iconContainer width.
	self assert: li height equals: li iconContainer height
]

{ #category : #tests }
ToLabeledIconTest >> testIconContainerHeight [

	| li |
	li := self newLabeledIconWithIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [ li iconContainer height: 40 ].
	self
		assert: li height
		equals: (li labelContainer height max: li iconContainer height)
]

{ #category : #tests }
ToLabeledIconTest >> testIconContainerHeightVertical [

	| li |
	li := self newLabeledIconWithIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li beVertical.
		li iconContainer height: 40 ].
	self
		assert: li height
		equals: li labelContainer height + li iconContainer height.
	self
		assert: li width
		equals: (li labelContainer width max: li iconContainer width)
]

{ #category : #tests }
ToLabeledIconTest >> testIconContainerWidth [

	| li |
	li := self newLabeledIconWithIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [ li iconContainer width: 40 ].
	self
		assert: li width
		equals: li labelContainer width + li iconContainer width.
	self
		assert: li height
		equals: (li labelContainer height max: li iconContainer height)
]

{ #category : #tests }
ToLabeledIconTest >> testIconContainerWidthVertical [

	| li |
	li := self newLabeledIconWithIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li beVertical.
		li iconContainer width: 40 ].
	self
		assert: li width
		equals: (li labelContainer width max: li iconContainer width).
	self
		assert: li height
		equals: li labelContainer height + li iconContainer height
]

{ #category : #tests }
ToLabeledIconTest >> testIconImage [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li iconImage:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself) ].
	self assert: li width equals: li iconContainer width.
	self assert: li height equals: li iconContainer height
]

{ #category : #tests }
ToLabeledIconTest >> testInitialize [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].
	self assert: li isStartToEnd.
	self assert: li isHorizontal.
	self assert: li extent equals: 0 asPoint
]

{ #category : #tests }
ToLabeledIconTest >> testInterspace [

	| li |
	li := ToLabeledIcon new.
	li startInterspace: 10.
	space deferAndSettle: [ space root addChild: li ].

	self assert: li extent equals: 10 @ 0.

	space deferAndSettle: [ li vFitContent ].
	self assert: li width equals: 10.
	self assert: li height equals: 0.

	space deferAndSettle: [ li label: (ToLabel text: 'X') ].
	self assert: li height equals: li label height.
	self assert: li width equals: li label width + 10
]

{ #category : #tests }
ToLabeledIconTest >> testInterspaceWithLabel [

	| li |
	li := ToLabeledIcon new.
	li startInterspace: 10.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	space deferAndSettle: [ space root addChild: li ].
	self
		assert: li labelContainer bounds left
		equals: li iconContainer bounds right + 10
]

{ #category : #tests }
ToLabeledIconTest >> testInterspaceWithLabelAndVertical [

	| li |
	li := ToLabeledIcon new.
	li vertical: true.
	li startInterspace: 10.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	space deferAndSettle: [ space root addChild: li ].
	self
		assert: li labelContainer bounds top
		equals: li iconContainer bounds bottom + 10
]

{ #category : #tests }
ToLabeledIconTest >> testIsExact [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].
	space deferAndSettle: [ li extent: 10 @ 10 ].
	self assert: li isExact.

	space deferAndSettle: [ li hMatchParent ].
	self deny: li isExact
]

{ #category : #tests }
ToLabeledIconTest >> testIsIconFirst [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [ li beStartToEnd ].
	self assert: li isStartToEnd.
	self deny: li isEndToStart.

]

{ #category : #tests }
ToLabeledIconTest >> testIsLabelFirst [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [ li beEndToStart ].
	self assert: li isEndToStart.
	self deny: li isStartToEnd.


]

{ #category : #tests }
ToLabeledIconTest >> testIsStartFlexible [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	self deny: li isStartFlexible.

	space deferAndSettle: [ li startFlexible: true ].
	self assert: li isStartFlexible
]

{ #category : #tests }
ToLabeledIconTest >> testLabel [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [ li label: (ToLabel text: 'A') ].
	self assert: li extent equals: li labelContainer extent.
	self assert: li hasLabel.

	space deferAndSettle: [ li label: nil ].
	self assert: li label isNil.
	self deny: li hasLabel
]

{ #category : #tests }
ToLabeledIconTest >> testLabelContainer [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	self assert: li labelContainer hasChildren not.
	self assert: li labelContainer extent equals: 0 asPoint.

	space deferAndSettle: [ li label: (ToLabel text: 'A') ].
	self assert: li extent equals: li labelContainer extent
]

{ #category : #tests }
ToLabeledIconTest >> testLabelFirst [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li iconImage:
			(BlElement new
				 extent: 60 @ 20;
				 background: (Color blue alpha: 0.2);
				 yourself).
		li labelText: 'X'.
		li endToStart: true ].
	self
		assert: (li label bounds inParent: li) right
		equals: (li icon bounds inParent: li) left
]

{ #category : #tests }
ToLabeledIconTest >> testLabelText [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [ li labelText: 'A' asRopedText ].
	self assert: li label text asString equals: 'A'.
	self assert: li extent equals: li labelContainer extent.
	self assert: li labelText equals: 'A'.

	space deferAndSettle: [ li labelText: 'X' ].
	self assert: li label text asString equals: 'X'.
	self assert: li extent equals: li labelContainer extent.
	self assert: li labelText equals: 'X'.

	space deferAndSettle: [ li label: nil ].
	self deny: li hasLabel.
	self assert: li extent equals: 0 asPoint
]

{ #category : #tests }
ToLabeledIconTest >> testStartAlignment [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li icon:
			(ToImage inner:
				(BlElement new
					extent: 60 @ 20;
					background: (Color blue alpha: 0.2);
					yourself)).
		li label: (ToLabel text: 'ba') ].
	self
		assert: li labelContainer bounds left
		equals: li iconContainer bounds right.

	space deferAndSettle: [ li startAlignment: 100 ].
	self assert: li iconContainer bounds width equals: 100.
	self assert: li labelContainer bounds left equals: 100.

	space deferAndSettle: [ li startAlignment: 50 ].
	self assert: li labelContainer bounds left equals: 50.
	self assert: li iconContainer bounds width equals: 50
]

{ #category : #tests }
ToLabeledIconTest >> testStartFlexible [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	self assert: li startFiller isNil.

	space deferAndSettle: [ li startFlexible: true ].
	self assert: li startFiller notNil.
	self assert: li isStartFlexible
]

{ #category : #tests }
ToLabeledIconTest >> testStartFlexibleInEmpty [

	| li container |
	container := ToElement new extent: 200 asPoint; yourself.

	li := ToLabeledIcon new.
	li startFlexible: true.
	self assert: li isStartFlexible.
	li matchParent.
	container addChild: li.
	space deferAndSettle: [ space root addChild: container ].
	self assert: li extent equals: 200 asPoint.

	space deferAndSettle: [ li vFitContent ].
	self assert: li width equals: 200.
	self assert: li height equals: 0.

	space deferAndSettle: [ li label: (ToLabel text: 'X') ].
	self assert: li height equals: li label height
]

{ #category : #tests }
ToLabeledIconTest >> testStartFlexibleWithLabel [

	| li container |
	container := ToElement new extent: 200 asPoint; yourself.
	li := ToLabeledIcon new.
	li matchParent.
	container addChild: li.
	li startFlexible: true.
	li vertical: false.
	li label: (ToLabel text: 'A').
	li icon:
		(ToImage inner:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself)).
	space deferAndSettle: [ space root addChild: container ].
	self assert: li labelContainer bounds right closeTo: container width.
	self assert: li iconContainer bounds left closeTo: 0
]

{ #category : #tests }
ToLabeledIconTest >> testStartFlexibleWithLabelAndVertical [

	| li container |
	container := ToElement new extent: 200 asPoint.
	li := ToLabeledIcon new.
	li vertical: true.
	li matchParent.
	container addChild: li.
	li startFlexible: true.
	li label: (ToLabel text: 'A').
	li icon:
		(ToImage inner:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself)).
	space deferAndSettle: [ space root addChild: container ].
	self assert: li labelContainer bounds bottom equals: container height.
	self assert: li iconContainer bounds top equals: 0
]

{ #category : #tests }
ToLabeledIconTest >> testStartToEnd [

	| li |
	li := self newLabeledIcon.
	space deferAndSettle: [ space root addChild: li ].

	space deferAndSettle: [
		li iconImage:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself).
		li labelText: 'X'.
		li startToEnd: true ].
	self
		assert: (li icon bounds inParent: li) right
		equals: (li label bounds inParent: li) left
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIcon [

	| li |
	li := self newLabeledIconWithIcon.
	space deferAndSettle: [ space root addChild: li ].
	self
		assert: li width
		equals: li labelContainer width + li iconContainer width.
	self
		assert: li height
		equals: (li labelContainer height max: li iconContainer height)
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconIconFirst [

	| li |
	li := ToLabeledIcon new.
	li endToStart: true.
	li endToStart: false.
	li label: (ToLabel text: 'A').
	li icon:
		(ToImage inner:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself)).
	space deferAndSettle: [ space root addChild: li ].
	self assert: li iconContainer bounds left equals: 0.
	self
		assert: li labelContainer bounds left
		equals: li iconContainer bounds right
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconIconFirstVertical [

	| li |
	li := ToLabeledIcon new.
	li endToStart: true.
	li endToStart: false.
	li vertical: true.
	li label: (ToLabel text: 'A').
	li icon:
		(ToImage inner:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself)).
	space deferAndSettle: [ space root addChild: li ].
	self assert: li iconContainer bounds top equals: 0.
	self
		assert: li labelContainer bounds top
		equals: li iconContainer bounds bottom
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconLabelFirst [

	| li |
	li := ToLabeledIcon new.
	li endToStart: true.
	li label: (ToLabel text: 'A').
	li icon:
		(ToImage inner:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself)).
	space deferAndSettle: [ space root addChild: li ].
	self assert: li labelContainer bounds left equals: 0.
	self
		assert: li iconContainer bounds left
		equals: li label bounds right
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconLabelFirstVertical [

	| li |
	li := ToLabeledIcon new.
	li endToStart: true.
	li vertical: true.
	li label: (ToLabel text: 'A').
	li icon:
		(ToImage inner:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself)).
	space deferAndSettle: [ space root addChild: li ].
	self assert: li labelContainer bounds top equals: 0.
	self
		assert: li iconContainer bounds top
		equals: li labelContainer bounds bottom
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconVertical [

	| li |
	li := ToLabeledIcon new.
	li vertical: true.
	li label: (ToLabel text: 'A').
	li icon:
		(ToImage inner:
			(BlElement new
				extent: 60 @ 20;
				background: (Color blue alpha: 0.2);
				yourself)).
	space deferAndSettle: [ space root addChild: li ].
	self
		assert: li height
		equals: li labelContainer height + li iconContainer height.
	self
		assert: li width
		equals: (li labelContainer width max: li iconContainer width)
]
