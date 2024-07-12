Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'listElement',
		'selecter',
		'enabled',
		'elementBuilder',
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

	^ (ToListSelectionOption separate)
		  beneath: false;
		  yourself
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

	elementBuilder := aSelectionElementBuilderValuable.
	self optionDo: [ :opt | opt elementBuilder: aSelectionElementBuilderValuable ]
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
	enabled := true.
	elementBuilder := self defaultElementBuilder 
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> installDefaultOption [

	option := self defaultOption.
	option onInstalledIn: self
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> installSelecter [

	selecter := self newSelecter.
	selecter ifNil: [ ^ self ].
	selecter selectionModel: self newSelectionModel.
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

{ #category : #testing }
ToAbstractListSelectionMode >> isPrimary [

	^ false
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
ToAbstractListSelectionMode >> newListEventHandler [

	^ nil
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelecter [

	^ ToListSelecter new
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionModel [

	^ listElement newSelectionModel
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onInstalledIn: anElement [

	listElement ifNotNil: [ Error signal: 'A selection mode can be installed only once' ].
	listElement := anElement.
	self installSelecter.
	option := self defaultOption.
	option onInstalledIn: self
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onUninstalledIn: anElement [

	option onUninstalledIn: self.
	self uninstallSelecter.
	option := nil.
	listElement := nil
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
ToAbstractListSelectionMode >> option: aListSelectionOption [

	option onUninstalledIn: self.
	option := aListSelectionOption.
	option onInstalledIn: self
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

	^ nil
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
ToAbstractListSelectionMode >> uninstallSelecter [

	selecter onUninstalledIn: listElement.
	selecter := nil
]
