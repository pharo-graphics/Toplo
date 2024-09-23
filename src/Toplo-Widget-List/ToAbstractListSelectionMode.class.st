Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'listElement',
		'enabled',
		'selecter',
		'option'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

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

{ #category : #initialization }
ToAbstractListSelectionMode >> installSelecter [

	selecter := self newSelecter.
	selecter selectionModel: (self newSelectionModelIn: listElement).
	selecter
		onInstalledIn: listElement;
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

{ #category : #accessing }
ToAbstractListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #accessing }
ToAbstractListSelectionMode >> listElement [

	^ listElement
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelecter [

	^ ToListSelecter new
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionModelIn: aListElement [

	^ aListElement newSelectionModel
]

{ #category : #initialization }
ToAbstractListSelectionMode >> on: aListElement [

	listElement ifNotNil: [ BlImmutableObjectChangeError new signal ].
	listElement := aListElement.
	listElement addSelectionMode: self.
	self installSelecter.
	option ifNotNil: [
		selecter selectionOption: option.
		option onMode: self ]
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
ToAbstractListSelectionMode >> option: aSelectionOption [

	option ifNotNil: [
		(BlImmutableObjectChangeError object: self) signal ].
	option := aSelectionOption.
	selecter ifNotNil: [ selecter selectionOption: option ]
]

{ #category : #accessing }
ToAbstractListSelectionMode >> optionDo: aBlock [

	option ifNil: [ ^ self ].
	aBlock value: option
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
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #initialization }
ToAbstractListSelectionMode >> uninstall [

	option ifNotNil: [ option onUninstalledIn: listElement ].
	self uninstallSelecter.
	listElement removeSelectionMode: self.
	option := nil.
	listElement := nil
]

{ #category : #initialization }
ToAbstractListSelectionMode >> uninstallSelecter [

	selecter onUninstalledIn: listElement.
	selecter := nil
]
