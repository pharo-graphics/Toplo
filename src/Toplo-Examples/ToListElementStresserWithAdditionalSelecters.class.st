Class {
	#name : #ToListElementStresserWithAdditionalSelecters,
	#superclass : #ToListElementStresser,
	#instVars : [
		'maxUnselectableIntervals',
		'maxHiddenIntervals',
		'maxDisabledIntervals'
	],
	#category : #'Toplo-Examples'
}

{ #category : #running }
ToListElementStresserWithAdditionalSelecters class >> run [

	<script>

	self new run

]

{ #category : #running }
ToListElementStresserWithAdditionalSelecters class >> runInSDL [

	<script>
	self new runInHost: BlOSWindowSDL2Host new
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionDisableAllIn: aList [

	aList disabledSelecter selectAll
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionDisableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList disabledSelecter selectIndex: idx ]
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionDisableIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList disabledSelecter selectIndexes: selected
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionEnableAllIn: aList [

	aList disabledSelecter deselectAll
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionEnableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList disabledSelecter deselectIndex: idx ]
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionEnableIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList disabledSelecter deselectIndexes: selected
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionHiddenIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList hiddenSelecter selectIndexes: selected
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionSelectableAllIn: aList [

	
		aList unselectableSelecter deselectAll
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionSelectableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList unselectableSelecter deselectIndex: idx ]
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionSelectableIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList unselectableSelecter deselectIndexes: selected
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionUnhiddenAllIn: aList [

	aList hiddenSelecter deselectAll
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionUnselectableAllIn: aList [

	aList unselectableSelecter selectAll
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionUnselectableIndexIn: aList [

	| idx |
	idx := self randIndexIn: aList.
	idx isZero ifFalse: [ aList unselectableSelecter selectIndex: idx ]
]

{ #category : #actions }
ToListElementStresserWithAdditionalSelecters >> actionUnselectableIndexesIn: aList [

	| nb selected |
	nb := (self randIndexIn: aList) min: 30.
	nb isZero ifTrue: [ ^ self ].
	selected := (1 to: nb) collect: [ :i | self randIndexIn: aList ].
	aList unselectableSelecter selectIndexes: selected
]

{ #category : #initialization }
ToListElementStresserWithAdditionalSelecters >> initialize [ 

	super initialize.
	maxUnselectableIntervals := 0.
	maxHiddenIntervals := 0.
	maxDisabledIntervals := 0
]

{ #category : #initialization }
ToListElementStresserWithAdditionalSelecters >> newListElement [

	| l |
	l := ToListElement new
		     nodeBuilder: [ :node :dataItem :holder  |
			     | lab |
			     lab := ToLabel text: dataItem.
			     node addChild: lab.
			     holder isSelectable ifFalse: [
					     node background: (Color red alpha: 0.1) ].
			     holder isDisabled ifTrue: [
					     node background: (Color veryLightGray alpha: 0.5) ] ];
		     yourself.
	"
	l newDisabledSelectionMode onInstalledIn: l.
	l newUnselectableSelectionMode onInstalledIn: l.
	l withHiddenSelecter.
	"
	l
		withHiddenSelecter;
		withUnselectableSelecter;
		withDisabledSelecter.

	^ l
]

{ #category : #running }
ToListElementStresserWithAdditionalSelecters >> selectActionsToRun [

	^ (super selectActionsToRun)
	  , (self class superclass selectors select: [ :selector |
			   selector beginsWith: #action ])
]

{ #category : #initialization }
ToListElementStresserWithAdditionalSelecters >> selectionResultsTextOn: aListElement [

	| nb t |
	t := super selectionResultsTextOn: aListElement.
	nb := aListElement unselectableSelectionModel underlyingModel
		      intervals size.
	maxUnselectableIntervals := nb max: maxUnselectableIntervals.
	t := t , ' < unselectable ' , nb asString , '/'
	  , maxUnselectableIntervals asString , ' >'.
	
	nb := aListElement hiddenSelectionModel underlyingModel
		      intervals size.
	maxHiddenIntervals := nb max: maxHiddenIntervals.
	t := t , ' < hidden ' , nb asString , '/'
	  , maxHiddenIntervals asString , ' >'.
	
	nb := aListElement disabledSelectionModel underlyingModel
		      intervals size.
	maxDisabledIntervals := nb max: maxDisabledIntervals.
	t := t , ' < disabled ' , nb asString , '/'
	  , maxDisabledIntervals asString , ' >'.
	
	^ t
]
