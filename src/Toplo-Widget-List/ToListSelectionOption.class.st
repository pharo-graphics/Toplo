Class {
	#name : #ToListSelectionOption,
	#superclass : #Object,
	#instVars : [
		'animationDuration'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'instance creation' }
ToListSelectionOption class >> grouped [ 

	^ ToListGroupedSelection new
]

{ #category : #'instance creation' }
ToListSelectionOption class >> none [ 

	^ ToListNoneSelection new
]

{ #category : #'instance creation' }
ToListSelectionOption class >> separate [

	^ ToListSeparateSelection new
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

{ #category : #initialization }
ToListSelectionOption >> initialize [ 

	super initialize.
	animationDuration := 0 milliSeconds 
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
ToListSelectionOption >> isSeparate [

	^ false
]

{ #category : #'nodes collecting' }
ToListSelectionOption >> nextPutNodeGroupsFrom: aListElement selectionModel: aSelectionModel in: aStream [

	self subclassResponsibility 
]
