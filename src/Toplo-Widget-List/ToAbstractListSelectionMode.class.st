Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'listEventHandler',
		'selecter',
		'enabled',
		'elementBuilder',
		'beneathOption',
		'overOption'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #configuring }
ToAbstractListSelectionMode >> beGroupedBeneathSelection [

	beneathOption := (ToListSelectionOption groupedForMode: self)
		                 beneath: true;
		                 triggerSelectionState:
			                 beneathOption triggerSelectionState;
		                 selectionContainer:
			                 beneathOption selectionContainer;
		                 yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beGroupedOverSelection [

	overOption := (ToListSelectionOption groupedForMode: self)
		              beneath: false;
		              triggerSelectionState:
			              beneathOption triggerSelectionState;
		              selectionContainer: overOption selectionContainer;
		              yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beNoneBeneathSelection [

	beneathOption := (ToListSelectionOption noneForMode: self)
		                 beneath: true;
		                 triggerSelectionState:
			                 beneathOption triggerSelectionState;
		                 selectionContainer:
			                 beneathOption selectionContainer;
		                 yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beNoneOverSelection [

	overOption := (ToListSelectionOption noneForMode: self)
		              beneath: false;
		              triggerSelectionState:
			              beneathOption triggerSelectionState;
		              selectionContainer: overOption selectionContainer;
		              yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beSeparateBeneathSelection [

	beneathOption := (ToListSelectionOption separateForMode: self)
		                 beneath: true;
		                 triggerSelectionState:
			                 beneathOption triggerSelectionState;
		                 selectionContainer:
			                 beneathOption selectionContainer;
		                 yourself
]

{ #category : #configuring }
ToAbstractListSelectionMode >> beSeparateOverSelection [

	overOption := (ToListSelectionOption separateForMode: self)
		              beneath: false;
		              triggerSelectionState:
			              beneathOption triggerSelectionState;
		              selectionContainer: overOption selectionContainer;
		              yourself
]

{ #category : #accessing }
ToAbstractListSelectionMode >> beneathElementBuilder: aSelectionElementBuilderValuable [

	beneathOption elementBuilder: aSelectionElementBuilderValuable
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
ToAbstractListSelectionMode >> elementBuilder [

	^ elementBuilder
]

{ #category : #accessing }
ToAbstractListSelectionMode >> elementBuilder: aSelectionElementBuilderValuable [

	elementBuilder := aSelectionElementBuilderValuable
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
		                 beneath: true;
		                 yourself.
	overOption := (ToListSelectionOption noneForMode: self)
		              beneath: false;
		              yourself.
	beneathOption onInstalledIn: anElement.
	overOption onInstalledIn: anElement.


]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> installSelecterIn: anElement [

	selecter
		onInstalledIn: anElement;
		enabled: self enabled;
		multiple: self isMultipleSelection
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

{ #category : #testing }
ToAbstractListSelectionMode >> isPrimary [

	^ false
]

{ #category : #testing }
ToAbstractListSelectionMode >> isSelectableNode: aNode [


	^ (self selectionModel containsIndex: aNode holder position)
			   and: [ aNode holder isHidden not ]
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
	self installSelecterIn: anElement.
	anElement addEventHandler: listEventHandler
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onUninstalledIn: anElement [

	anElement removeEventHandler: listEventHandler.
	self uninstallSelecterIn: anElement.
	self uninstallDefaultOptionsIn: anElement.
	selecter := nil
]

{ #category : #accessing }
ToAbstractListSelectionMode >> operator [

	^ selecter operator
]

{ #category : #accessing }
ToAbstractListSelectionMode >> overElementBuilder: aSelectionElementBuilderValuable [

	overOption elementBuilder: aSelectionElementBuilderValuable
]

{ #category : #accessing }
ToAbstractListSelectionMode >> overOption [

	^ overOption
]

{ #category : #private }
ToAbstractListSelectionMode >> refreshSelectionIn: aListElement [

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
ToAbstractListSelectionMode >> selectionElements [

	^ Array streamContents: [ :stream |
		  stream nextPutAll: beneathOption selectionElements.
		  stream nextPutAll: overOption selectionElements ]
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> uninstallDefaultOptionsIn: anElement [

	beneathOption onUninstalledIn: anElement.
	overOption onUninstalledIn: anElement


]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> uninstallSelecterIn: anElement [

	selecter onUninstalledIn: anElement.
	selecter := nil
]

{ #category : #private }
ToAbstractListSelectionMode >> updateSelectionIn: aListElement [

	beneathOption groupHolder updateSelectionIn: aListElement.
	overOption groupHolder updateSelectionIn: aListElement
]
