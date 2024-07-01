Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'listEventHandler',
		'selecter',
		'enabled',
		'elementClass',
		'beneathOption',
		'overOption'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #configuring }
ToAbstractListSelectionMode >> beGroupedBeneathSelection [

	beneathOption := (ToListSelectionOption groupedForMode: self)
		              selectionContainer: beneathOption selectionContainer;
		              yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beGroupedOverSelection [

	overOption := (ToListSelectionOption groupedForMode: self)
		              selectionContainer: overOption selectionContainer;
		              yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beNoneBeneathSelection [

	beneathOption := (ToListSelectionOption noneForMode: self)
		                 selectionContainer:
			                 beneathOption selectionContainer;
		                 yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beNoneOverSelection [

	overOption := (ToListSelectionOption noneForMode: self)
		                 selectionContainer:
			                 overOption selectionContainer;
		                 yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beSeparateBeneathSelection [

	
	beneathOption := (ToListSelectionOption separateForMode: self)
		              selectionContainer: beneathOption selectionContainer;
		              yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beSeparateOverSelection [

	overOption := (ToListSelectionOption separateForMode: self)
		              selectionContainer: overOption selectionContainer;
		              yourself
]

{ #category : #accessing }
ToAbstractListSelectionMode >> beneathOption [

	^ beneathOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> disable [

	self enabled: false
]

{ #category : #accessing }
ToAbstractListSelectionMode >> elementClass [

	^ elementClass 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> elementClass: aSelectionElementClass [

	elementClass := aSelectionElementClass
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enable [

	self enabled: true
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enabled [

	^ enabled
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enabled: aBoolean [
 
	enabled = aBoolean ifTrue: [ ^ self ].
	enabled := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter enabled: aBoolean
]

{ #category : #initialization }
ToAbstractListSelectionMode >> initialize [

	super initialize.
	enabled := true
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> installDefaultOptionsIn: anElement [

	beneathOption := (ToListSelectionOption groupedForMode: self)
		                 selectionContainer: anElement beneathContainer;
		                 yourself.
	overOption := (ToListSelectionOption noneForMode: self)
		              selectionContainer: anElement overContainer;
		              yourself.

]

{ #category : #testing }
ToAbstractListSelectionMode >> isDisabled [

	^ self enabled not
]

{ #category : #testing }
ToAbstractListSelectionMode >> isEnabled [

	^ self enabled
]

{ #category : #testing }
ToAbstractListSelectionMode >> isMultipleSelection [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #accessing }
ToAbstractListSelectionMode >> listEventHandler: anEventHandler [

	listEventHandler := anEventHandler
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onInstalledIn: anElement [

	self installDefaultOptionsIn: anElement.
	selecter
		onInstalledIn: anElement;
		enabled: self enabled;
		multiple: self isMultipleSelection.
	anElement addEventHandler: listEventHandler
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onUninstalledIn: anElement [

	anElement removeEventHandler: listEventHandler.
	selecter onUninstalledIn: anElement.
	selecter := nil
]

{ #category : #accessing }
ToAbstractListSelectionMode >> operator [

	^ selecter operator
]

{ #category : #accessing }
ToAbstractListSelectionMode >> overElementClass: aSelectionElementClass [

	overOption elementClass: aSelectionElementClass
]

{ #category : #accessing }
ToAbstractListSelectionMode >> overOption [

	^ overOption
]

{ #category : #private }
ToAbstractListSelectionMode >> refreshSelectionIn: aListElement [
	" return a collection with instances of ToListPrimarySelectionElement "

	beneathOption groupHolder refreshSelectionIn: aListElement.
	overOption groupHolder refreshSelectionIn: aListElement.
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectedIndexes [

	^ self selectionModel indexes
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectedIndexesCount [

	^ self selectionModel selectedIndexesCount
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selecter [

	^ selecter 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selecter: aSelecter [

	selecter := aSelecter
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #private }
ToAbstractListSelectionMode >> updateSelectionIn: aListElement [
	" return a collection with instances of ToListPrimarySelectionElement "

	beneathOption groupHolder updateSelectionIn: aListElement.
	overOption groupHolder updateSelectionIn: aListElement
]
