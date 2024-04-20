Class {
	#name : #ToListElementStresserWithAdditionalSelecters,
	#superclass : #ToListElementStresser,
	#category : #'Toplo-Examples'
}

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
ToListElementStresserWithAdditionalSelecters >> newListElement [

	^ ToListElement new
		  withHiddenSelecter;
		  withUnselectableSelecter;
		  withDisabledSelecter;
			nodeBuilder: [ :node :holder |
		holder isUnselectable ifTrue: [ node background: Color red ].
		node addChild: (ToLabel text: holder dataItem asString) hMatchParent ];
		  yourself
]

{ #category : #running }
ToListElementStresserWithAdditionalSelecters >> selectActionsToRun [

	^ (super selectActionsToRun)
	  , (self class superclass selectors select: [ :selector |
			   selector beginsWith: #action ])
]
