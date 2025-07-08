"
A ToLabeledIconTest is a test class for testing the behavior of ToLabeledIcon
"
Class {
	#name : #ToLabeledIconTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core'
}

{ #category : #running }
ToLabeledIconTest >> setUp [ 

	super setUp.
	ToTheme cleanUp
]

{ #category : #tests }
ToLabeledIconTest >> testBeIconFirst [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li beStartToEnd.
	li applyWidgetConfiguration.
	self assert: li isStartToEnd
]

{ #category : #tests }
ToLabeledIconTest >> testBeLabelFirst [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li beEndToStart.
	self assert: li isEndToStart
]

{ #category : #tests }
ToLabeledIconTest >> testFiller [

	| li |
	li := self testInitialize.
	self assert: li startFiller isNil.
	li startFlexible: false.
	li applyWidgetConfiguration.
	self assert: li startFiller isNil.
	li startFlexible: true.
	li applyWidgetConfiguration.
	self assert: li startFiller notNil
]

{ #category : #tests }
ToLabeledIconTest >> testHasIcon [

	| li |
	li := self testInitialize.
	self deny: li hasIcon.
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	self assert: li hasIcon
]

{ #category : #tests }
ToLabeledIconTest >> testHasLabel [

	| li |
	li := self testInitialize.
	self deny: li hasLabel.
	li label: (ToLabel text: 'A').
	self assert: li hasLabel.

]

{ #category : #tests }
ToLabeledIconTest >> testIcon [

	| li |
	li := self testInitialize.
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	li applyWidgetConfiguration.
	self assert: li width equals: li iconContainer width.
	self assert: li height equals: li iconContainer height.
	self assert: li hasIcon.
	li icon: nil.
	self assert: li icon isNil.
	self deny: li hasIcon.

	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testIconContainer [

	| li |
	li := self testInitialize.
	self assert: li iconContainer isNil.
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	li applyWidgetConfiguration.
	self assert: li startContainer notNil.
	self assert: li width equals: li iconContainer width.
	self assert: li height equals: li iconContainer height.
	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testIconContainerHeight [

	| li |
	li := self testWithLabelAndIcon.
	li iconContainer height: 40.
	li forceLayout.
	self
		assert: li height
		equals: (li labelContainer height max: li iconContainer height)
]

{ #category : #tests }
ToLabeledIconTest >> testIconContainerHeightVertical [

	| li |
	li := self testWithLabelAndIcon.
	li beVertical.
	li iconContainer height: 40.
	li forceLayout.
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
	li := self testWithLabelAndIcon.
	li iconContainer width: 40.
	li forceLayout.
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
	li := self testWithLabelAndIcon.
	li beVertical.
	li iconContainer width: 40.
	li forceLayout.
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
	li := self testInitialize.
	li iconImage: (BlElement new
			 extent: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself).
	li applyWidgetConfiguration.
	li forceLayout.
	self assert: li width equals: li iconContainer width.
	self assert: li height equals: li iconContainer height.
	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testInitialize [

	| li |
	li := ToLabeledIcon new.
	self assert: li isStartToEnd.
	self assert: li isHorizontal.
	li applyWidgetConfiguration.
	li forceLayout.

	self assert: li extent equals: 0 asPoint.
	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testInterspace [

	| li |
	li := ToLabeledIcon new.
	li startInterspace: 10.
	li applyWidgetConfiguration.
	li forceLayout.
	self assert: li extent equals: 10 @ 0.
	li vFitContent.
	li forceLayout.
	self assert: li width equals: 10.
	self assert: li height equals: 0.
	li label: (ToLabel text: 'X').
	li forceLayout.
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
	li applyWidgetConfiguration.
	li forceLayout.
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
	li applyWidgetConfiguration.
	li forceLayout.
	self
		assert: li labelContainer bounds top
		equals: li iconContainer bounds bottom + 10
]

{ #category : #tests }
ToLabeledIconTest >> testIsExact [

	| li |
	li := self testInitialize.
	li extent: 10@10.
	self assert: li isExact.
	li hMatchParent.
	self deny: li isExact.


]

{ #category : #tests }
ToLabeledIconTest >> testIsIconFirst [

	| li |
	li := self testInitialize.
	li beStartToEnd.
	self assert: li isStartToEnd.
	self deny: li isEndToStart.

]

{ #category : #tests }
ToLabeledIconTest >> testIsLabelFirst [

	| li |
	li := self testInitialize.
	li beEndToStart.
	self assert: li isEndToStart.
	self deny: li isStartToEnd.


]

{ #category : #tests }
ToLabeledIconTest >> testIsStartFlexible [

	| li |
	li := self testInitialize.
	self deny: li isStartFlexible.
	li startFlexible: true.
	self assert: li isStartFlexible
]

{ #category : #tests }
ToLabeledIconTest >> testLabel [

	| li |
	li := self testInitialize.
	li label: (ToLabel text: 'A').
	li forceLayout.
	self assert: li extent equals: li labelContainer extent.
	self assert: li hasLabel.
	li label: nil.
	self assert: li label isNil.
	self deny: li hasLabel.

	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testLabelContainer [

	| li |
	li := self testInitialize.
	self assert: li labelContainer hasChildren not.
	self assert: li labelContainer extent equals: 0 asPoint.
	li label: (ToLabel text: 'A').
	li forceLayout.
	self assert: li size equals: li labelContainer size.
	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testLabelFirst [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li labelText: 'X'.
	li endToStart: true.
	li forceLayout.
	li applyWidgetConfiguration.

	self assert: (li label bounds inParent: li) right equals: (li icon bounds inParent: li) left.
	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testLabelText [

	| li |
	li := self testInitialize.
	li labelText: 'A' asRopedText.
	li forceLayout.
	self assert: li label text asString equals: 'A'.
	self assert: li extent equals: li labelContainer size.
	self assert: li labelText equals: 'A'.
	li labelText: 'X'.
	li forceLayout.
	self assert: li label text asString equals: 'X'.
	self assert: li size equals: li labelContainer size.
	self assert: li labelText equals: 'X'.
	li label: nil.
	li forceLayout.
	self deny: li hasLabel.
	self assert: li size equals: 0 asPoint.
	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testStartAlignment [

	| li |
	li := self testInitialize.
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li label: (ToLabel text: 'ba').
	li forceLayout.
	li applyWidgetConfiguration.
	self
		assert: li labelContainer bounds left
		equals: li iconContainer bounds right.
	li startAlignment: 100.
	li applyWidgetConfiguration.
	li forceLayout.
	self assert: li iconContainer bounds width equals: 100.
	self assert: li labelContainer bounds left equals: 100.
	li startAlignment: 50.
	li applyWidgetConfiguration.
	li forceLayout.
	self assert: li labelContainer bounds left equals: 50.
	self assert: li iconContainer bounds width equals: 50.

	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testStartFlexible [

	| li |
	li := self testInitialize.
	self assert: li startFiller isNil.
	li startFlexible: true.
	li forceLayout.
	li applyWidgetConfiguration.
	self assert: li startFiller notNil.
	self assert: li isStartFlexible
]

{ #category : #tests }
ToLabeledIconTest >> testStartFlexibleInEmpty [

	| li container |
	container := ToElement new extent: 200 asPoint.
	li := ToLabeledIcon new.
	li startFlexible: true.
	self assert: li isStartFlexible.
	li matchParent.
	container addChild: li.
	li forceLayout.
	self assert: li extent equals: 200 asPoint.
	li vFitContent.
	li forceLayout.
	self assert: li width equals: 200.
	self assert: li height equals: 0.
	li label: (ToLabel text: 'X').
	li forceLayout.
	self assert: li height equals: li label height
]

{ #category : #tests }
ToLabeledIconTest >> testStartFlexibleWithLabel [

	| li container |
	container := ToElement new extent: 200 asPoint.
	li := ToLabeledIcon new.
	li matchParent.
	container addChild: li.
	li startFlexible: true.
	li vertical: false.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li applyWidgetConfiguration.
	container forceLayout.
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
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li applyWidgetConfiguration.
	container forceLayout.
	self assert: li labelContainer bounds bottom equals: container height.
	self assert: li iconContainer bounds top equals: 0
]

{ #category : #tests }
ToLabeledIconTest >> testStartToEnd [

	| li |
	li := self testInitialize.
	li iconImage: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself).
	li labelText: 'X'.
	li startToEnd: true.
	li applyWidgetConfiguration.
	li forceLayout.
	self assert: (li icon bounds inParent: li) right equals: (li label bounds inParent: li) left.
	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIcon [

	| li |
	li := self testLabel.
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li forceLayout.
	li applyWidgetConfiguration.
	self
		assert: li width
		equals: li labelContainer width + li iconContainer width.
	self
		assert: li height
		equals: (li labelContainer height max: li iconContainer height).
	^ li
]

{ #category : #tests }
ToLabeledIconTest >> testWithLabelAndIconIconFirst [

	| li |
	li := ToLabeledIcon new.
	li endToStart: true.
	li endToStart: false.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li applyWidgetConfiguration.
	li forceLayout.
	
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
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li applyWidgetConfiguration.
	li forceLayout.
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
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li applyWidgetConfiguration.
	li forceLayout.
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
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li applyWidgetConfiguration.
	li forceLayout.
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
	li icon: (ToImage inner: (BlElement new
				  extent: 60 @ 20;
				  background: (Color blue alpha: 0.2);
				  yourself)).
	li applyWidgetConfiguration.
	li forceLayout.
	self
		assert: li height
		equals: li labelContainer height + li iconContainer height.
	self
		assert: li width
		equals: (li labelContainer width max: li iconContainer width)
]
