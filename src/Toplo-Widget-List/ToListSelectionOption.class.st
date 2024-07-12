Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#instVars : [
		'beneath',
		'triggerSelectionState',
		'animationDuration',
		'selectionContainer',
		'groupHolder',
		'selectionModel',
		'listEventHandler',
		'elementBuilder'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionOption class >> grouped [

	^ ToListGroupedSelection new
]

{ #category : #'instance creation' }
ToListSelectionOption class >> separate [

	^ ToListSeparateSelection new
]

{ #category : #'instance creation' }
ToListSelectionOption >> addSelectionElement: aSelectionElement [

	selectionContainer addChild: aSelectionElement
]

{ #category : #'instance creation' }
ToListSelectionOption >> addSelectionElements: aSelectionElementArray [

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
ToListSelectionOption >> elementBuilder: aSelectionElementBuilderValuable [

	elementBuilder := aSelectionElementBuilderValuable
]

{ #category : #accessing }
ToListSelectionOption >> groupHolder [ 

	^ groupHolder 
]

{ #category : #initialization }
ToListSelectionOption >> initialize [ 

	super initialize.
	triggerSelectionState := false.
	animationDuration := 0 milliSecond
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
ToListSelectionOption >> isOver [

	^ self isBeneath not
]

{ #category : #testing }
ToListSelectionOption >> isSeparate [

	^ false
]

{ #category : #'instance creation' }
ToListSelectionOption >> newSelectionContainerIn: anElement [

	| container elevation |
	container := ToOverlayElement new.
	container clipChildren: false.
	container attachTo: anElement innerContainer.
	elevation := beneath
		             ifTrue: [ BlRelativeElevation elevation: 5 ]
		             ifFalse: [ BlRelativeElevation elevation: 15 ].
	container elevation: elevation.
	^ container
]

{ #category : #'instance creation' }
ToListSelectionOption >> newSelectionElementIn: aListElement [

	^ elementBuilder value
		  selectionOption: self;
		  focused: aListElement isFocused;
		  yourself
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onInstalledIn: aSelectionMode [

	elementBuilder := aSelectionMode elementBuilder.
	selectionModel := aSelectionMode selectionModel.
	groupHolder := ToSelectionGroupHolder new.
	groupHolder option: self.
	groupHolder mode: aSelectionMode.
	
	listEventHandler := aSelectionMode newListEventHandler.
	listEventHandler selectionGroupHolder: groupHolder.
	aSelectionMode listElement addEventHandler: listEventHandler.

	selectionContainer := self newSelectionContainerIn: aSelectionMode listElement.
	aSelectionMode listElement addChild: selectionContainer
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onUninstalledIn: aSelectionMode [

	aSelectionMode listElement removeEventHandler: listEventHandler.
	selectionContainer removeFromParent.
	selectionContainer := nil.
	listEventHandler := nil.
	elementBuilder := nil.
	selectionModel := nil.
	groupHolder := nil
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

{ #category : #testing }
ToListSelectionOption >> triggerSelectionState [

	^ triggerSelectionState
]

{ #category : #accessing }
ToListSelectionOption >> triggerSelectionState: aBoolean [

	triggerSelectionState := aBoolean
]
