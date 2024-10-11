Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'listElement',
		'enabled',
		'selecter',
		'selectionElementOption'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToAbstractListSelectionMode >> changeSelectionElementOptionWith: aSelectionOption [

	selectionElementOption ifNotNil: [
		selectionElementOption onUninstalledIn: listElement ].
	selectionElementOption := aSelectionOption.
	selectionElementOption ifNil: [ ^ self ].
	selectionElementOption onInstalledIn: listElement
]

{ #category : #initialization }
ToAbstractListSelectionMode >> defaultSelectionElementOption [

	^ nil
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

{ #category : #initialization }
ToAbstractListSelectionMode >> installSelecter [

	selecter := self newSelecter.
	selecter selectionMode: self.
	selecter selectionModel: self newSelectionModel.
	selecter selectionChangedEventClass: self selectionChangedEventClass.
	selecter
		onInstalledIn: listElement;
		enabled: self enabled;
		multiple: self isMultipleSelection
]

{ #category : #initialization }
ToAbstractListSelectionMode >> installSelectionElementOption [

	selectionElementOption := self defaultSelectionElementOption.
	selectionElementOption ifNil: [ ^ self ].
	selectionElementOption onInstalledIn: listElement
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

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionChangedEventHandler [

	^ nil
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListSelectionMode >> on: aListElement [

	listElement ifNotNil: [
		(BlImmutableObjectChangeError object: listElement) signal ].
	listElement := aListElement.
	listElement addSelectionMode: self.
	self newSelectionChangedEventHandler ifNotNil: [ :handler |
		listElement addEventHandler: handler ].
	self installSelecter.
	self installSelectionElementOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> operator [

	^ selecter operator
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
ToAbstractListSelectionMode >> selectionElementOption [

	^ selectionElementOption 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionElementOptionDo: aBlock [

	selectionElementOption ifNil: [ ^ self ].
	aBlock value: selectionElementOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #initialization }
ToAbstractListSelectionMode >> uninstall [

	selectionElementOption ifNotNil: [ selectionElementOption onUninstalledIn: listElement ].
	self uninstallSelecter.
	listElement removeSelectionMode: self.
	selectionElementOption := nil.
	listElement := nil
]

{ #category : #initialization }
ToAbstractListSelectionMode >> uninstallSelecter [

	selecter onUninstalledIn: listElement.
	selecter := nil
]
