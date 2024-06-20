Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#instVars : [
		'animationDuration',
		'selectionMode',
		'elementClass',
		'groupHolder'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionOption class >> groupedForMode: aSelectionMode [

	^ ToListGroupedSelection basicNew
		  selectionMode: aSelectionMode;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
ToListSelectionOption class >> noneForMode: aSelectionMode [

	^ ToListNoneSelection basicNew
		  selectionMode: aSelectionMode;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
ToListSelectionOption class >> separateForMode: aSelectionMode [

	^ ToListSeparateSelection basicNew
		  selectionMode: aSelectionMode;
		  initialize;
		  yourself
]

{ #category : #accessing }
ToListSelectionOption >> animate [

	^ animationDuration asMilliSeconds > 0
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
ToListSelectionOption >> elementClass [

	^ elementClass ifNil: [ elementClass := selectionMode defaultElementClass ]
]

{ #category : #accessing }
ToListSelectionOption >> elementClass: aSelectionElementClass [

	elementClass := aSelectionElementClass
]

{ #category : #accessing }
ToListSelectionOption >> groupHolder [ 

	^ groupHolder 
]

{ #category : #initialization }
ToListSelectionOption >> initialize [ 

	super initialize.
	animationDuration := 0 milliSecond.
	groupHolder := ToSelectionGroupHolder new.
	groupHolder option: self.

]

{ #category : #testing }
ToListSelectionOption >> isBeneath [

	^ selectionMode beneathOption = self 
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
ToListSelectionOption >> isPrimary [

	^ selectionMode isPrimarySelectionMode
]

{ #category : #testing }
ToListSelectionOption >> isSeparate [

	^ false
]

{ #category : #'instance creation' }
ToListSelectionOption >> newSelectionElementFor: aListElement [

	^ self elementClass selectionOption: self focused: aListElement hasFocus
]

{ #category : #'nodes collecting' }
ToListSelectionOption >> nextPutSelectionGroupsFrom: aListElement in: aStream [

	self subclassResponsibility 
]

{ #category : #accessing }
ToListSelectionOption >> selectionMode [

	^ selectionMode 
]

{ #category : #accessing }
ToListSelectionOption >> selectionMode: aSelectionMode [

	selectionMode := aSelectionMode
]
