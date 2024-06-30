Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#instVars : [
		'animationDuration',
		'elementClass',
		'selectionContainer',
		'groupHolder',
		'selectionMode'
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

{ #category : #'nodes collecting' }
ToListSelectionOption >> collectSelectionGroupsFrom: aListElement [

	^ self currentSelectionGroupsFrom: aListElement
]

{ #category : #'nodes collecting' }
ToListSelectionOption >> currentSelectionGroupsFrom: aListElement [

	self subclassResponsibility 
]

{ #category : #accessing }
ToListSelectionOption >> elementClass [

	^ elementClass ifNil: [ elementClass := selectionMode elementClass ]
]

{ #category : #accessing }
ToListSelectionOption >> elementClass: aSelectionElementClass [

	elementClass := aSelectionElementClass
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

	^ selectionContainer isBeneath
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

{ #category : #'instance creation' }
ToListSelectionOption >> newSelectionElementFor: aListElement [

	^ self elementClass selectionOption: self focused: aListElement isFocused
]

{ #category : #accessing }
ToListSelectionOption >> selectionContainer [

	^ selectionContainer
]

{ #category : #accessing }
ToListSelectionOption >> selectionContainer: anElement [

	selectionContainer := anElement
]

{ #category : #accessing }
ToListSelectionOption >> selectionMode [

	^ selectionMode 
]

{ #category : #accessing }
ToListSelectionOption >> selectionMode: aSelectionMode [

	selectionMode := aSelectionMode
]
