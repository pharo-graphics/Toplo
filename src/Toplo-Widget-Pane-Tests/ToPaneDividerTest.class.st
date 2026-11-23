"
I check that dragging a `ToPaneDivider` moves it and resizes its elements, and that it is placed in the middle of the gap between them.
"
Class {
	#name : #ToPaneDividerTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Widget-Pane-Tests'
}

{ #category : #helpers }
ToPaneDividerTest >> drag: aDivider from: aStartPoint to: anEndPoint [

	aDivider dispatchEvent: (BlDragStartEvent new
		 position: aStartPoint;
		 yourself).
	aDivider dispatchEvent: (BlDragEvent new
		 position: anEndPoint;
		 modifiers: BlKeyModifiers new;
		 yourself).
	self settle
]

{ #category : #helpers }
ToPaneDividerTest >> newPaneWithDivider [
	"Answer an open horizontal pane with two elements of fixed width and the divider between them."

	| pane |
	pane := ToPane horizontal withNullSkin.
	pane extent: 400 @ 300.
	pane addChildren: (#( 100 200 ) collect: [ :width |
		 ToElement new
			 vMatchParent;
			 width: width;
			 yourself ]).
	pane addDividers.
	space root addChild: pane.
	self settle.
	^ pane
]

{ #category : #helpers }
ToPaneDividerTest >> newVerticalPaneWithLowerMargin: anInsets [
	"Answer an open vertical pane with two elements, the lower one with the given margin, and the divider between them."

	| pane upper lower |
	pane := ToPane vertical withNullSkin.
	pane extent: 200 @ 400.
	upper := ToElement new
		         height: 100;
		         hMatchParent;
		         yourself.
	lower := ToElement new
		         height: 100;
		         hMatchParent;
		         margin: anInsets;
		         yourself.
	pane addChildren: {
		upper.
		lower }.
	pane addDividers.
	space root addChild: pane.
	self settle.
	^ pane
]

{ #category : #helpers }
ToPaneDividerTest >> settle [

	5 timesRepeat: [ space settle ]
]

{ #category : #tests }
ToPaneDividerTest >> testDragDispatchesOneDividerDragEvent [

	| divider count |
	divider := self newPaneWithDivider dividers first.
	count := 0.
	divider addEventHandlerOn: ToDividerDragEvent do: [ :event | count := count + 1 ].
	self drag: divider from: 100 @ 50 to: 130 @ 50.
	self assert: count equals: 1
]

{ #category : #tests }
ToPaneDividerTest >> testDragMovesDivider [

	| divider startX |
	divider := self newPaneWithDivider dividers first.
	startX := divider position x.
	self drag: divider from: 100 @ 50 to: 130 @ 50.
	self assert: divider position x equals: startX + 30
]

{ #category : #tests }
ToPaneDividerTest >> testDragResizesElements [

	| pane |
	pane := self newPaneWithDivider.
	self drag: pane dividers first from: 100 @ 50 to: 130 @ 50.
	self assert: pane firstChild width equals: 130.
	self assert: pane children second width equals: 170
]

{ #category : #tests }
ToPaneDividerTest >> testHorizontalDividerIsCenteredBetweenMargins [
	"The lower element has a top margin and no bottom margin: the gap is between the margins."

	| divider |
	divider := (self newVerticalPaneWithLowerMargin: (BlInsets top: 20 bottom: 0)) dividers first.
	self assert: divider position y + (divider thickness / 2) equals: 100
]

{ #category : #tests }
ToPaneDividerTest >> testHorizontalDividerIsCenteredWithSymmetricMargin [

	| divider |
	divider := (self newVerticalPaneWithLowerMargin: (BlInsets all: 20)) dividers first.
	self assert: divider position y + (divider thickness / 2) equals: 100
]
