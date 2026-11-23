"
I am the divider between two elements of a `ToPane`. The user drags me to give more room to one element and less to the other.

I am created with the two elements I separate, with `between:and:`; `new` is an error. `weight:` sets the weight of the first one. See `ToDivider` for the drag itself.

## Examples

```
ToPaneDivider exampleDefault
```

## Design Rationale

- I follow my elements instead of keeping a size of my own: after each layout I center myself in the gap between them, so resizing the window, or changing the orientation or direction of the pane, keeps me in place.
- Elements that match their parent keep their size as a weight, recomputed as the fraction of the pane they occupy, so the proportions stay when the pane is resized. Other elements get an explicit width or height.
- Dragging with Shift resizes only the first element, and gives both elements an explicit size instead of a weight.

## Usage

1. `ToPane>>addDividers` and `ToPane>>addDividerBetween:and:` create me and add me to the pane.
2. When I am added, `ToPaneDividerEventHandler` gives me the orientation across the one of the pane, and listens to the pane and to my two elements to place me again.
3. `ToPane>>dividers` answers me; `ToPane>>removeDividers` removes me.

## Implementation Notes

- `onMeasure:` writes the weights of my two elements each time I am measured, from their measured sizes. A weight set on an element between two measures is therefore only a starting point.

## Invariants and Assumptions

- My two elements are children of the same pane as me, and stay so as long as I am there.
"
Class {
	#name : #ToPaneDivider,
	#superclass : #ToDivider,
	#instVars : [
		'firstResizedElement',
		'secondResizedElement'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'instance creation' }
ToPaneDivider class >> between: aFirstElement and: aSecondElement [

	^ self basicNew
		  firstResizedElement: aFirstElement;
		  secondResizedElement: aSecondElement;
		  initialize;
		  yourself
]

{ #category : #examples }
ToPaneDivider class >> exampleDefault [
	"A pane whose two elements are resized by dragging their divider."

	<example>
	^ self instanceDefault parent openInSpace
]

{ #category : #instances }
ToPaneDivider class >> instanceDefault [

	<sampleInstance>
	^ self instanceInHorizontalPane
]

{ #category : #instances }
ToPaneDivider class >> instanceInHorizontalPane [
	"Answer the first divider of a pane of three elements side by side."

	<sampleInstance>
	| pane |
	pane := ToPane horizontal matchParent.
	pane addChildren: ({
		 Color blue.
		 Color red.
		 Color green } collect: [ :color | ToPane demoElementColored: color ]).
	^ pane addDividers first
]

{ #category : #instances }
ToPaneDivider class >> instanceInVerticalPane [
	"Answer the first divider of a pane of three stacked elements."

	<sampleInstance>
	| pane |
	pane := ToPane vertical matchParent.
	pane addChildren: ({
		 Color blue.
		 Color red.
		 Color green } collect: [ :color | ToPane demoElementColored: color ]).
	^ pane addDividers first
]

{ #category : #instances }
ToPaneDivider class >> instanceWeighted [
	"Answer a divider that gives a smaller weight to the first of two elements."

	<sampleInstance>
	| pane |
	pane := ToPane horizontal matchParent.
	pane addChildren: ({
		 Color blue.
		 Color red } collect: [ :color | ToPane demoElementColored: color ]).
	^ pane addDividers first
		  weight: 0.3;
		  yourself
]

{ #category : #'instance creation' }
ToPaneDivider class >> new [

	^ self error: 'Use between:and:'
]

{ #category : #accessing }
ToPaneDivider >> bottomResizedElement [

	^ self topResizedElement = self firstResizedElement
		  ifTrue: [ self secondResizedElement ]
		  ifFalse: [ self firstResizedElement ]
]

{ #category : #layout }
ToPaneDivider >> canApplyLayoutOnPanes [

	^ self hasParent and: [ self parent width isZero not ]
]

{ #category : #initialization }
ToPaneDivider >> defaultEventHandler [ 

	^ ToPaneDividerEventHandler new
]

{ #category : #accessing }
ToPaneDivider >> firstResizedElement [

	^ firstResizedElement
]

{ #category : #accessing }
ToPaneDivider >> firstResizedElement: anElement [

	firstResizedElement := anElement
]

{ #category : #layout }
ToPaneDivider >> layoutHorizontally [

	| firstY secondY gap |
	firstY := self topResizedElement bounds bottom
	          + self topResizedElement margin bottom.
	secondY := self bottomResizedElement bounds top
	           - self bottomResizedElement margin top.

	gap := secondY - firstY / 2 - (self thickness / 2).
	" since I'm ignored by layout, I can set my position explicitely here "
	self position: 0 @ (firstY + gap)
]

{ #category : #layout }
ToPaneDivider >> layoutVertically [

	| gap firstX secondX |
	firstX := self leftResizedElement bounds right
	          + self leftResizedElement margin right.

	secondX := self rightResizedElement bounds left
	           - self rightResizedElement margin left.

	gap := secondX - firstX - self thickness / 2.
	" since I'm ignored by layout, I can set my position explicitely here "
	self position: (firstX + gap) @ 0
]

{ #category : #accessing }
ToPaneDivider >> leftResizedElement [

	^ self firstResizedElement bounds left < self secondResizedElement bounds left
		  ifTrue: [ self firstResizedElement ]
		  ifFalse: [ self secondResizedElement ]
]

{ #category : #layout }
ToPaneDivider >> measureHorizontally [

	| w |
		
	w := self resizedElementWeightFromHeight:
		     self firstResizedElement measuredHeight.
	self firstResizedElement constraints linear weight: w.

	w := self resizedElementWeightFromHeight:
		     self secondResizedElement measuredHeight.
	self secondResizedElement constraints linear weight: w
]

{ #category : #layout }
ToPaneDivider >> measureVertically [

	| w |

	w := self resizedElementWeightFromWidth:
		     self firstResizedElement measuredWidth.
	self firstResizedElement constraints linear weight: w.

	w := self resizedElementWeightFromWidth:
		     self secondResizedElement measuredWidth.
	self secondResizedElement constraints linear weight: w
]

{ #category : #layout }
ToPaneDivider >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self layoutHorizontally ]
		ifFalse: [ self layoutVertically ].


]

{ #category : #layout }
ToPaneDivider >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.
	self canApplyLayoutOnPanes ifFalse: [ ^ self ].

	self isHorizontal
		ifTrue: [ self measureHorizontally ]
		ifFalse: [ self measureVertically ]
]

{ #category : #accessing }
ToPaneDivider >> resizedElementWeightFromHeight: aWidth [

	^ aWidth / self parent height
]

{ #category : #accessing }
ToPaneDivider >> resizedElementWeightFromWidth: aWidth [

	^ aWidth / self parent width
]

{ #category : #accessing }
ToPaneDivider >> rightResizedElement [

	^ self leftResizedElement = self firstResizedElement
		  ifTrue: [ self secondResizedElement ]
		  ifFalse: [ self firstResizedElement ]
]

{ #category : #accessing }
ToPaneDivider >> secondResizedElement [

	^ secondResizedElement
]

{ #category : #accessing }
ToPaneDivider >> secondResizedElement: anElement [

	secondResizedElement := anElement
]

{ #category : #accessing }
ToPaneDivider >> topResizedElement [

	^ self firstResizedElement bounds top < self secondResizedElement bounds top
		  ifTrue: [ self firstResizedElement ]
		  ifFalse: [ self secondResizedElement ]
]

{ #category : #accessing }
ToPaneDivider >> weight: aFloat [

	self constraints linear weight: aFloat.
	self firstResizedElement constraints linear weight: aFloat.
]
