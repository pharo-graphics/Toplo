Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'selecter',
		'selectionElementOption'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToAbstractListSelectionMode >> changeSelectionElementOptionWith: aSelectionOption in: aListElement [

	selectionElementOption ifNotNil: [
		selectionElementOption onUninstalledIn: aListElement ].
	selectionElementOption := aSelectionOption.
	selectionElementOption ifNil: [ ^ self ].
	selectionElementOption onInstalledIn: aListElement
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
ToAbstractListSelectionMode >> makeDisabledUnselectable: aBoolean [

	self selectionModel makeDisabledUnselectable: aBoolean
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
ToAbstractListSelectionMode >> newSelectionModelIn: aListElement [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListSelectionMode >> on: aListElement [

	self
		deprecated: 'Use #onInstalledIn:'
		transformWith: '`@rcvr on: `@arg' -> '`@rcvr onInstalledIn: `@arg'.
	self onInstalledIn: aListElement
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onInstalledIn: aListElement [

	aListElement addSelectionMode: self.
	self newSelectionChangedEventHandler ifNotNil: [ :handler |
		aListElement addEventHandler: handler ].
	selecter := self newSelecter.
	selecter selectionMode: self.
	selecter selectionModel: (self newSelectionModelIn: aListElement).
	selecter selectionChangedEventClass: self selectionChangedEventClass.
	selecter enabled: self enabled.
	selecter multiple: self isMultipleSelection.
	selecter onInstalledIn: aListElement.
	selectionElementOption := self defaultSelectionElementOption.
	selectionElementOption ifNil: [ ^ self ].
	selectionElementOption onInstalledIn: aListElement
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onUninstalledIn: aListElement [

	selectionElementOption ifNotNil: [ selectionElementOption onUninstalledIn: aListElement ].
	selecter onUninstalledIn: aListElement.
	aListElement removeSelectionMode: self.
	selectionElementOption := nil.
	selecter := nil.

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
