Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'selecter',
		'enabled',
		'option'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToAbstractListSelectionMode >> defaultElementBuilder [ 

	^ [ ToListBasicSelectionElement new ]
]

{ #category : #initialization }
ToAbstractListSelectionMode >> defaultOption [

	^ ToListSelectionOption separate
		  beneath: false;
		  yourself
]

{ #category : #accessing }
ToAbstractListSelectionMode >> disable [

	self enabled: false
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
ToAbstractListSelectionMode >> installSelecterIn: aListElement [

	selecter := self newSelecter.
	selecter ifNil: [ ^ self ].
	selecter selectionModel: (self newSelectionModelIn: aListElement).
	selecter
		onInstalledIn: aListElement;
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

	^ true
]

{ #category : #testing }
ToAbstractListSelectionMode >> isPrimary [

	^ false
]

{ #category : #accessing }
ToAbstractListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newListEventHandler [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelecter [

	^ ToListSelecter new
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionModelIn: aListElement [

	^ aListElement newSelectionModel
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onInstalledIn: aListElement [

	option ifNotNil: [
		Error signal: 'A selection mode can be installed only once' ].

	self installSelecterIn: aListElement.

	option := self defaultOption.
	option
		elementBuilder: self defaultElementBuilder;
		selectionModel: self selectionModel;
		listEventHandler: self newListEventHandler.
	option onInstalledIn: aListElement
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onUninstalledIn: aListElement [

	option onUninstalledIn: aListElement.
	self uninstallSelecterIn: aListElement.
	option := nil
]

{ #category : #accessing }
ToAbstractListSelectionMode >> operator [

	^ selecter operator
]

{ #category : #accessing }
ToAbstractListSelectionMode >> option [

	^ option 
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

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> selectionChangedEventClass [ 

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionElements [

	^ option selectionElements
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> uninstallSelecterIn: aListElement [

	selecter onUninstalledIn: aListElement.
	selecter := nil
]
