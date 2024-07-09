Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#instVars : [
		'beneath',
		'triggerSelectionState',
		'animationDuration',
		'selectionContainer',
		'groupHolder',
		'selectionMode',
		'elementBuilder'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionOption class >> groupedForMode: aSelectionMode [

	^ ToListGroupedSelection new
		  selectionMode: aSelectionMode;
		  yourself
]

{ #category : #'instance creation' }
ToListSelectionOption class >> noneForMode: aSelectionMode [

	^ ToListNoneSelection new
		  selectionMode: aSelectionMode;
		  yourself
]

{ #category : #'instance creation' }
ToListSelectionOption class >> separateForMode: aSelectionMode [

	^ ToListSeparateSelection new
		  selectionMode: aSelectionMode;
		  yourself
]

{ #category : #'instance creation' }
ToListSelectionOption >> addSelectionElement: aSelectionElement [

	self isNone ifTrue: [ ^ self ].
	selectionContainer addChild: aSelectionElement
]

{ #category : #'instance creation' }
ToListSelectionOption >> addSelectionElements: aSelectionElementArray [

	self isNone ifTrue: [ ^ self ].
	selectionContainer addChildren: aSelectionElementArray
]

{ #category : #accessing }
ToListSelectionOption >> animationDuration [

	^ animationDuration
]

{ #category : #accessing }
ToListSelectionOption >> animationDuration: aDuration [

	animationDuration := aDuration
]

{ #category : #accessing }
ToListSelectionOption >> beneath: aBoolean [

	beneath := aBoolean
]

{ #category : #'nodes collecting' }
ToListSelectionOption >> collectSelectionGroupsFrom: aListElement [

	^ self currentSelectionGroupsFrom: aListElement
]

{ #category : #'nodes collecting' }
ToListSelectionOption >> currentSelectionGroupsFrom: aListElement [

	self subclassResponsibility 
]

{ #category : #accessing }
ToListSelectionOption >> elementBuilder [

	^ elementBuilder ifNil: [ elementBuilder := selectionMode elementBuilder ]
]

{ #category : #accessing }
ToListSelectionOption >> elementBuilder: aSelectionElementBuilderValuable [

	elementBuilder := aSelectionElementBuilderValuable
]

{ #category : #accessing }
ToListSelectionOption >> groupHolder [ 

	^ groupHolder 
]

{ #category : #accessing }
ToListSelectionOption >> groupHolder: aGroupHolder [

	groupHolder := aGroupHolder 
]

{ #category : #initialization }
ToListSelectionOption >> initialize [ 

	super initialize.
	triggerSelectionState := false.
	animationDuration := 0 milliSecond.
	groupHolder := ToSelectionGroupHolder new.
	groupHolder option: self
]

{ #category : #accessing }
ToListSelectionOption >> isAnimated [

	^ animationDuration asMilliSeconds > 0
]

{ #category : #testing }
ToListSelectionOption >> isBeneath [

	^ beneath
]

{ #category : #testing }
ToListSelectionOption >> isGrouped [

	^ false
]

{ #category : #testing }
ToListSelectionOption >> isNone [

	^ false
]

{ #category : #testing }
ToListSelectionOption >> isOver [

	^ self isBeneath not
]

{ #category : #testing }
ToListSelectionOption >> isSeparate [

	^ false
]

{ #category : #'api - hooks' }
ToListSelectionOption >> newInnerContainerIn: anElement [

	| container |
	container := ToOverlayElement new.
	container clipChildren: false.
	container attachTo: anElement innerContainer.
	^ container
]

{ #category : #'instance creation' }
ToListSelectionOption >> newSelectionElementFor: aListElement [

	" elementBuilder is lazy "
	^ self elementBuilder value
		  selectionOption: self;
		  focused: aListElement isFocused;
		  yourself
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onInstalledIn: anElement [

	| elevation |
	self isNone ifTrue: [ ^ self ].
	selectionContainer := self newInnerContainerIn: anElement.
	elevation := beneath
		             ifTrue: [ BlRelativeElevation elevation: 5 ]
		             ifFalse: [ BlRelativeElevation elevation: 15 ].
	selectionContainer elevation: elevation.
	anElement addChild: selectionContainer
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onUninstalledIn: anElement [

	selectionContainer ifNil: [ ^ self ].
	selectionContainer removeFromParent
]

{ #category : #accessing }
ToListSelectionOption >> selectionContainer [

	^ selectionContainer
]

{ #category : #accessing }
ToListSelectionOption >> selectionContainer: aSelectionContainer [

	selectionContainer := aSelectionContainer
]

{ #category : #accessing }
ToListSelectionOption >> selectionElements [

	^ selectionContainer children select: [ :child |
		  child isKindOf: ToListSelectionElement ]
]

{ #category : #accessing }
ToListSelectionOption >> selectionMode [

	^ selectionMode 
]

{ #category : #accessing }
ToListSelectionOption >> selectionMode: aSelectionMode [

	selectionMode := aSelectionMode
]

{ #category : #testing }
ToListSelectionOption >> triggerSelectionState [

	^ triggerSelectionState
]

{ #category : #accessing }
ToListSelectionOption >> triggerSelectionState: aBoolean [

	triggerSelectionState := aBoolean
]
