Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#instVars : [
		'masked',
		'grouped',
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

	^ self new grouped: true
]

{ #category : #'instance creation' }
ToListSelectionOption class >> separate [

	^ self new grouped: false
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

	beneath := aBoolean.
	selectionContainer ifNotNil: [ | elevation |
	elevation := beneath
		             ifTrue: [ BlRelativeElevation elevation: 5 ]
		             ifFalse: [ BlRelativeElevation elevation: 15 ].
	selectionContainer elevation: elevation ]
]

{ #category : #'nodes collecting' }
ToListSelectionOption >> collectSelectionGroupsFrom: aListElement [

	^ self currentSelectionGroupsFrom: aListElement
]

{ #category : #'nodes collecting' }
ToListSelectionOption >> currentSelectionGroupsFrom: aListElement [

	^ grouped
		  ifTrue: [
			  (aListElement innerContainer nodeGroupsSatisfying: [ :node |
				   selectionModel containsIndex: node holder position ]) collect: [
				  :arr | ToNeighboringSelection new nodes: arr ] ]
		  ifFalse: [
			  (aListElement innerContainer nodesSelect: [ :node |
				   selectionModel containsIndex: node holder position ]) collect: [
				  :node | ToSeparateSelection new node: node ] ]
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
ToListSelectionOption >> grouped: aBoolean [

	grouped := aBoolean
]

{ #category : #initialization }
ToListSelectionOption >> initialize [ 

	super initialize.
	triggerSelectionState := false.
	animationDuration := 0 milliSecond.
	masked := false
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

	^ grouped
]

{ #category : #testing }
ToListSelectionOption >> isOver [

	^ self isBeneath not
]

{ #category : #testing }
ToListSelectionOption >> isSeparate [

	^ self isGrouped not
]

{ #category : #accessing }
ToListSelectionOption >> listEventHandler: aListEventHandler [

	listEventHandler := aListEventHandler
]

{ #category : #accessing }
ToListSelectionOption >> masked [

	^ masked
]

{ #category : #accessing }
ToListSelectionOption >> masked: aBoolean [

	masked := aBoolean
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
ToListSelectionOption >> onInstalledIn: aListElement [

	groupHolder := ToSelectionGroupHolder new.
	groupHolder option: self.
	listEventHandler selectionGroupHolder: groupHolder.
	aListElement addEventHandler: listEventHandler.

	selectionContainer := self newSelectionContainerIn: aListElement.
	aListElement addChild: selectionContainer
]

{ #category : #'api - hooks' }
ToListSelectionOption >> onUninstalledIn: aListElement [

	aListElement removeEventHandler: listEventHandler.
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

{ #category : #accessing }
ToListSelectionOption >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #testing }
ToListSelectionOption >> triggerSelectionState [

	^ triggerSelectionState
]

{ #category : #accessing }
ToListSelectionOption >> triggerSelectionState: aBoolean [

	triggerSelectionState := aBoolean
]
